//
//  String.swift
//  Toudly
//
//  Created by 김지훈 on 2023/01/13.
//

import Foundation

extension String {
    
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
    func localized(with argument: CVarArg = [], comment: String = "") -> String {
        return String(format: self.localized(comment: comment), argument)
    }
    
    //MARK: 날짜 형식 확인
    func stringToDate() -> Date? {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
//        if Locale.current.languageCode == "ko" {
//            dateFormatter.dateFormat = "yyyy-MM-dd"
//        }
        
        if let date = dateFormatter.date(from: self) {
            return date
        }
        else {
            return nil
        }
    }
}
