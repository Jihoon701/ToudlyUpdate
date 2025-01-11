//
//  RealmService.swift
//  Todo
//
//  Created by 김지훈 on 2022/05/12.
//

import Foundation
import RealmSwift

class RealmService {
    static let shared = RealmService()
    var realm = try! Realm()
    
//    func getData() -> [TodoList] {
//        selectedData = 
//        Array(realm.observe(TodoList.self).filter(\.checkbox == false).sorted(by: \.id))
//        realm.objects(TodoList.self).filter("date == %@", selectedDate).sorted(byKeyPath: "order", ascending: true)
//    }
//    
    func updateRealmCheckbox(id: Int, checkbox: Bool) {
        try! realm.write {
            realm.create(TodoList.self, value: ["id": id, "checkbox": checkbox], update: .modified)
        }
    }
}

