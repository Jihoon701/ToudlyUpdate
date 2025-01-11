//
//  AlarmDetailViewController.swift
//  Todo
//
//  Created by 김지훈 on 2022/04/19.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class AlarmDetailViewController: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var AlarmTableView: UITableView!
    let realm = try! Realm()
    var alarmlist: Results<TodoList>!
    weak var delegate: MoveToMainDetailDelegate?
    
    override func viewDidLoad() {
        noticeLabel.setupNoticeLabel(labelText: "There are no todo lists with notification\nTry adding notifications!".localized())
        AlarmTableView.delegate = self
        AlarmTableView.dataSource = self
        alarmlist = realm.objects(TodoList.self).filter("alarm = true").sorted(byKeyPath: "date", ascending: true)
        AlarmTableView.register( UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
        alarmDataLayout()
        super.viewDidLoad()
    }
    
    func alarmDataLayout() {
        if alarmlist.count == 0 {
            noticeLabel.isHidden = false
        }
        else {
            noticeLabel.isHidden = true
        }
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Notification".localized())
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(TodoList.self).filter("alarm = true").count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AlarmTableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
        cell.configureDetailCell(target: alarmlist[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.moveToMainDetail(selectedDate: alarmlist[indexPath.row].date)
    }
}
