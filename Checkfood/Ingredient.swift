//
//  Ingredients.swift
//  Checkfood
//
//  Created by Felipe Umpierre on 19/10/15.
//  Copyright © 2015 Felipe Umpierre. All rights reserved.
//

import Foundation

class Ingredient: NSObject, NSCoding {
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObjectForKey("id") as! Int
        let name = aDecoder.decodeObjectForKey("name") as! String
        
        self.init(id: id, name: name)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.id, forKey: "id")
        aCoder.encodeObject(self.name, forKey: "name")
    }
}