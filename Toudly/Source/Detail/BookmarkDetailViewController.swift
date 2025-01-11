//
//  BookmarkDetailViewController.swift
//  Todo
//
//  Created by 김지훈 on 2022/04/20.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class BookmarkDetailViewController: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var bookmarkTableView: UITableView!
    @IBOutlet weak var noticeLabel: UILabel!
    let realm = try! Realm()
    var bookmarkList: Results<TodoList>!
    weak var delegate: MoveToMainDetailDelegate?
    
    override func viewDidLoad() {
        noticeLabel.setupNoticeLabel(labelText: "There are no todo lists with bookmarks\nTry adding bookmarks!".localized())
        bookmarkTableView.delegate = self
        bookmarkTableView.dataSource = self
        bookmarkList = realm.objects(TodoList.self).filter("bookmark = true").sorted(byKeyPath: "date", ascending: true)
        bookmarkTableView.register( UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
        bookmarkDataLayout()
        super.viewDidLoad()
    }
    
    func bookmarkDataLayout() {
        if bookmarkList.count == 0 {
            noticeLabel.isHidden = false
        }
        else {
            noticeLabel.isHidden = true
        }
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Bookmark".localized())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(TodoList.self).filter("bookmark = true").count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookmarkTableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
        cell.configureDetailCell(target: bookmarkList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.moveToMainDetail(selectedDate: bookmarkList[indexPath.row].date)
    }
}
