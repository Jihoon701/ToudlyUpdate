//
//  UITableView.swift
//  Todo
//
//  Created by 김지훈 on 2022/02/08.
//

import Foundation
import UIKit

extension UITableView {
    
    func scrollToBottom() {
        let rows = self.numberOfRows(inSection: 0)
        if rows > 0 {
            let indexPath = IndexPath(row: rows - 1, section: 0)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func setBottomInset(to value: CGFloat) {
        let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)
        self.contentInset = edgeInset
        self.scrollIndicatorInsets = edgeInset
    }
    
    func becomeFirstResponderTextField() {
        if let cell = self.visibleCells.last {
            for view in cell.contentView.subviews {
                if let textfield = view as? UITextField {
                    textfield.becomeFirstResponder()
                    return
                }
            }
        }
    }
}
