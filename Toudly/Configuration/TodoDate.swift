//
//  TodoDate.swift
//  Todo
//
//  Created by 김지훈 on 2022/06/13.
//

import Foundation

class TodoDate {
    let todoCalendar = TodoCalendar()
    
    public func changeDayStatus(checkCurrentDayMonth: Bool) -> String {
        if checkCurrentDayMonth {
            return String(todoCalendar.currentDate.day)
        }
        else {
            return String(1)
        }
    }
    
    public func changeEditedDayStatus(editedDate: String) -> String {
        return editedDate
    }
    
    public func changeSelectedDate(selectedDate: String) -> String {
        return selectedDate
    }
}
