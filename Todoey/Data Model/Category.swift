//
//  Category.swift
//  Todoey
//
//  Created by Saul Juan Antonio Lionheart Cuautle on 7/25/19.
//  Copyright © 2019 Saul Juan Antonio Lionheart Cuautle. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
}
