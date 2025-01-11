//
//  OpenSourceViewController.swift
//  Todo
//
//  Created by 김지훈 on 2022/04/21.
//

import UIKit

class OpenSourceViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func BackToHomeVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        titleLabel.setupTitleLabel(text: "Open Source".localized())
        super.viewDidLoad()
    }
}
