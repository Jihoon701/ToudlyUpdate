//
//  IncompleteDetailViewController.swift
//  Todo
//
//  Created by 김지훈 on 2022/04/20.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class IncompleteDetailViewController: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var incompleteTableView: UITableView!
    @IBOutlet weak var noticeLabel: UILabel!
    let realm = try! Realm()
    var incompleteList: Results<TodoList>!
    weak var delegate: MoveToMainDetailDelegate?
    
    override func viewDidLoad() {
        noticeLabel.setupNoticeLabel(labelText: "There are no todo lists in progress\nTry adding todo lists!".localized())
        incompleteTableView.delegate = self
        incompleteTableView.dataSource = self
        incompleteList = realm.objects(TodoList.self).filter("checkbox = false").sorted(byKeyPath: "date", ascending: true)
        incompleteTableView.register( UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
        incompleteDataLayout()
        super.viewDidLoad()
    }
    
    func incompleteDataLayout() {
        if incompleteList.count == 0 {
            noticeLabel.isHidden = false
        }
        else {
            noticeLabel.isHidden = true
        }
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "In progress".localized())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(TodoList.self).filter("checkbox = false").count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = incompleteTableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
        incompleteList = realm.objects(TodoList.self).filter("checkbox = false").sorted(byKeyPath: "date", ascending: true)
        cell.configureDetailCell(target: incompleteList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.moveToMainDetail(selectedDate: incompleteList[indexPath.row].date)
    }
}
