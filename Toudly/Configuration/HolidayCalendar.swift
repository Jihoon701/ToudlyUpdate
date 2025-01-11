//
//  HolidayCalendar.swift
//  Toudly
//
//  Created by 김지훈 on 2023/01/13.
//

import Foundation

struct HolidayInfo {
    let year: Int
    let month: Int
    let day: Int
    let name: String
}

class HolidayCalendar {
    var holidayInfoArray = [HolidayInfo]()
    
    func setHolidayInfoArray(holidayItems: [Item]) {
        for item in holidayItems {
            let itemLocDate = String(item.locdate)
            let holidayYear = Int(itemLocDate.prefix(4))
            
            let startIndex = itemLocDate.index(itemLocDate.startIndex, offsetBy: 4)
            let endIndex = itemLocDate.index(itemLocDate.startIndex, offsetBy: 6)
            let range: Range<String.Index> = startIndex..<endIndex
            let holidayMonth = Int(itemLocDate[range])
            
            let holidayDay = Int(itemLocDate.suffix(2))
            let holidayName = setHolidayName(dateName: item.dateName)
            
            holidayInfoArray.append(HolidayInfo(year: holidayYear!, month: holidayMonth!, day: holidayDay!, name: holidayName))
        }
        print(holidayInfoArray)
    }
    
    func setHolidayName(dateName: String) -> String {
        switch dateName {
        case "1월1일":
            return "신정"
        case "부처님오신날":
            return "석가탄신일"
        case "기독탄신일":
            return "성탄절"
        default:
            return dateName
        }
    }
}
