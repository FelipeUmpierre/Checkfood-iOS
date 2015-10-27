//
//  Menu.swift
//  Checkfood
//
//  Created by Felipe Umpierre on 15/10/15.
//  Copyright © 2015 Felipe Umpierre. All rights reserved.
//

import Foundation

class Product: NSObject, NSCoding {
    
    // MARK: - Property
    
    var id: Int
    var name: String
    var descriptive: String
    var price: Double
    
    var ingredients: [Ingredient]?
    var quantity: Int?
    var observation: String?
    
    // MARK: - init
    
    init(id: Int, name: String, description: String, price: Double) {
        self.id = id
        self.name = name
        self.descriptive = description
        self.price = price
        
        super.init()
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent(NSArchiverPath.archiverProducts)
    
    // MARK: - Converting Array to String
    
    func ingredientList() -> String {
        var arrayOfIngredients: [String] = [String]()
        
        for ingredient in self.ingredients! {
            arrayOfIngredients.append(ingredient.name)
        }
        
        return arrayOfIngredients.joinWithSeparator(", ")
    }
    
    // MARK: - NSCoding
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObjectForKey("id") as! Int
        let name = aDecoder.decodeObjectForKey("name") as! String
        let descriptive = aDecoder.decodeObjectForKey("descriptive") as! String
        let price = aDecoder.decodeObjectForKey("price") as! Double
        
        self.init(id: id, name: name, description: descriptive, price: price)
        
        if let ingredients = aDecoder.decodeObjectForKey("ingredients") as? [Ingredient] {
            self.ingredients = ingredients
        }
        
        if let quantity = aDecoder.decodeObjectForKey("quantity") as? Int {
            self.quantity = quantity
        }

        if let observation = aDecoder.decodeObjectForKey("observation") as? String {
            self.observation = observation
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.id, forKey: "id")
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.descriptive, forKey: "descriptive")
        aCoder.encodeObject(self.price, forKey: "price")
        aCoder.encodeObject(self.ingredients, forKey: "ingredients")
        aCoder.encodeObject(self.quantity, forKey: "quantity")
        aCoder.encodeObject(self.observation, forKey: "observation")
    }
}