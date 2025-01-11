//
//  AlarmSettingViewController.swift
//  Todo
//
//  Created by 김지훈 on 2022/04/25.
//

import UIKit
import RealmSwift

class AlarmSettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var alarmSettingTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    let realm = try! Realm()
    let center = UNUserNotificationCenter.current()
    let alarmSettingTitle = ["Allow notification".localized(), "Delete all notification".localized()]
    
    @IBAction func backToSettingVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        titleLabel.setupTitleLabel(text: "Notification".localized())
        alarmSettingTableView.delegate = self
        alarmSettingTableView.dataSource = self
        alarmSettingTableView.register( UINib(nibName: "SettingDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingDetailTableViewCell")
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        super.viewDidLoad()
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmSettingTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = alarmSettingTableView.dequeueReusableCell(withIdentifier: "SettingDetailTableViewCell", for: indexPath) as! SettingDetailTableViewCell
        cell.titleLabel.text = alarmSettingTitle[indexPath.row]
        cell.selectionStyle = .none
        if indexPath.row == 1 {
            cell.settingSwitch.isHidden = true
        }
        else {
            cell.settingSwitch.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            break
        case 1:
            self.presentAlert(title: "Notice".localized(), message: "Press OK button to delete notifications".localized(), isCancelActionIncluded: true) { [self] action in
                try! realm.write {
                    realm.delete(realm.objects(TodoList.self).filter("checkbox = true"))
                }
                center.removeAllPendingNotificationRequests()
                self.presentBottomAlert(message: "Notification data deleted".localized())
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return alarmSettingTableView.frame.width * 1/8
    }
}
