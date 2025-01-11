//
//  UIImage.swift
//  Todo
//
//  Created by 김지훈 on 2022/05/31.
//

import Foundation
import UIKit

extension UIImage {
    
    func coloredBookmarkImage() -> UIImage {
        if Constant.bookmarkColor == nil {
            Constant.bookmarkColor = "green"
        }
        return UIImage(named: "bookmark_\(Constant.bookmarkColor!)")!
    }
}
