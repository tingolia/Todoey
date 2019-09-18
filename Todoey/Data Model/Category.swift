//
//  Category.swift
//  Todoey
//
//  Created by Thomas Ingolia on 9/13/19.
//  Copyright © 2019 Thomas Ingolia. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
