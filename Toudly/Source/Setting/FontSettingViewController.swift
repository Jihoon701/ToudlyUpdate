//
//  FontSettingViewController.swift
//  Toudly
//
//  Created by 김지훈 on 1/17/24.
//

import UIKit

class FontSettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fontSettingTableView: UITableView!
    
    let fontSettingTitle = ["NanumSquareRound".localized(), "Manrope".localized(), "NanumBarunGothic".localized(), "Suit".localized()]
    
    @IBAction func backToScreenSettingVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        setUI()
        super.viewDidLoad()
    }
    
    func setUI() {
        titleLabel.setupTitleLabel(text: "Font".localized())
        fontSettingTableView.delegate = self
        fontSettingTableView.dataSource = self
        fontSettingTableView.register( UINib(nibName: "SettingDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingDetailTableViewCell")
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        super.viewDidLoad()
    }
    
    func adjustFont() {
        titleLabel.setupTitleLabel(text: "Font".localized())
        fontSettingTableView.reloadData()
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontSettingTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = fontSettingTableView.dequeueReusableCell(withIdentifier: "SettingDetailTableViewCell", for: indexPath) as! SettingDetailTableViewCell
        cell.titleLabel.text = fontSettingTitle[indexPath.row]
        let labelText = fontSettingTitle[indexPath.row]
        cell.titleLabel.text = fontSettingTitle[indexPath.row]
        cell.titleLabel.font = UIFont.appRegularFont(14)
        cell.settingSwitch.isHidden = true
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            FontManager.selectedFontType = .nanumSquareRound
            adjustFont()
        case 1:
            FontManager.selectedFontType = .manrope
            adjustFont()
        case 2:
            FontManager.selectedFontType = .nanumBarunGothic
            adjustFont()
        case 3:
            FontManager.selectedFontType = .suit
            adjustFont()
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fontSettingTableView.frame.width * 1/8
    }
}
