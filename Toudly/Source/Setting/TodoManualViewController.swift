//
//  TodoManualViewController.swift
//  Todo
//
//  Created by 김지훈 on 2022/06/23.
//

import UIKit

class TodoManualViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var todoManualImageView: UIImageView!
    
    @IBAction func backToSettingVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        titleLabel.setupTitleLabel(text: "Instruction".localized())
        todoManualImageView.image = UIImage(named: "todoManual_en")
        
        if Locale.current.languageCode == "ko" {
            todoManualImageView.image = UIImage(named: "todoManual")
        }
        
        super.viewDidLoad()
    }
}
