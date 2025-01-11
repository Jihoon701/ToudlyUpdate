//
//  ScreenSettingViewController.swift
//  Todo
//
//  Created by 김지훈 on 2022/05/31.
//

import UIKit

protocol ScreenSettingDelegate: AnyObject {
    func reloadBookmarkImage()
}

class ScreenSettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bookmarkSettingLabel: UILabel!
    @IBOutlet weak var bookmarkColorCheckImage: UIImageView!
    @IBOutlet var bookmarkColorButtons: [UIButton]!
    @IBOutlet weak var screenSettingTableView: UITableView!
    
    let bookmarkColors = ["apricot", "green", "red", "turquoise", "yellow"]
    let screenSettingTitle = ["Font".localized()]
    
    @IBAction func backToSettingVC(_ sender: Any) {
        NotificationCenter.default.post(name: Constant.reloadBookmark, object: nil)
        self.navigationController?.popViewController(animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        adjustFont()
    }
    
    override func viewDidLoad() {
        setUI()
        super.viewDidLoad()
    }
    
    func setUI() {
        titleLabel.setupTitleLabel(text: "Display".localized())
        bookmarkSettingLabel.setupLabel(text: "Set Bookmark Color".localized())
        initColorButtons()
        bookmarkColorCheckImage.image = UIImage(named: "bookmark_gray")
        bookmarkColorCheckImage.image = UIImage.coloredBookmarkImage(bookmarkColorCheckImage.image!)()
        screenSettingTableView.register( UINib(nibName: "SettingDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingDetailTableViewCell")
        screenSettingTableView.delegate = self
        screenSettingTableView.dataSource = self
    }
    
    func adjustFont() {
        titleLabel.setupTitleLabel(text: "Display".localized())
        bookmarkSettingLabel.setupLabel(text: "Set Bookmark Color".localized())
        screenSettingTableView.reloadData()
    }
    
    func initColorButtons() {
        for colorButton in bookmarkColorButtons {
            colorButton.addTarget(self, action: #selector(bookmarkColorSelected(sender:)), for: .touchUpInside)
        }
    }
    
    @objc func bookmarkColorSelected (sender: UIButton) {
        Constant.bookmarkColor = sender.titleLabel?.text!
        self.bookmarkColorCheckImage.image = UIImage.coloredBookmarkImage(self.bookmarkColorCheckImage.image!)()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return screenSettingTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = screenSettingTableView.dequeueReusableCell(withIdentifier: "SettingDetailTableViewCell", for: indexPath) as! SettingDetailTableViewCell
        cell.titleLabel.text = screenSettingTitle[indexPath.row]
        cell.titleLabel.font = UIFont.appRegularFont(14)
        cell.settingSwitch.isHidden = true
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = storyboard?.instantiateViewController(withIdentifier: "FontSettingViewController") as! FontSettingViewController
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenSettingTableView.frame.width * 1/8
    }
}
