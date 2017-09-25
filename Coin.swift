//
//  File.swift
//  ChartTest
//
//  Created by Michael Yu on 7/19/17.
//  Copyright © 2017 Michael Yu. All rights reserved.
//

import Foundation
import RealmSwift

class Coin: Object {
    
    dynamic var name: String = String()
    dynamic var count: Int = Int(0)

    func save() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
}
