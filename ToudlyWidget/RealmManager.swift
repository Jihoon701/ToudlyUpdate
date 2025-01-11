//
//  RealmManager.swift
//  Toudly
//
//  Created by 김지훈 on 1/10/25.
//

import UIKit
import RealmSwift

class RealmManager {
    private init() { }
    
    static let shared: RealmManager = .init()
    
    private var localRealm = try! Realm()
    
    func getData() -> [TodoList] {
        Array(localRealm.objects(TodoList.self))
    }
}
