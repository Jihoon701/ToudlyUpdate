//
//  UITextField.swift
//  Todo
//
//  Created by 김지훈 on 2022/04/13.
//

import Foundation
import UIKit

extension UITextField {
    
    func setupLeftImage(imageName:String) {
        let heightSize = self.frame.height
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: heightSize * 0.7, height: heightSize))
        let imageView = UIImageView(frame: CGRect(x: heightSize * 0.2 , y: imageContainerView.center.y - heightSize * 0.25, width: heightSize * 0.5, height: heightSize * 0.5))
        imageView.image = UIImage(named: imageName)
        imageContainerView.addSubview(imageView)
        leftView = imageContainerView
        leftViewMode = .always
        self.tintColor = .gray
    }
}

