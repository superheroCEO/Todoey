//
//  Item.swift
//  Todoey
//
//  Created by Saul Juan Antonio Lionheart Cuautle on 7/25/19.
//  Copyright © 2019 Saul Juan Antonio Lionheart Cuautle. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
