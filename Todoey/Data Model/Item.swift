//
//  Item.swift
//  Todoey
//
//  Created by Thomas Ingolia on 9/13/19.
//  Copyright © 2019 Thomas Ingolia. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")

}
