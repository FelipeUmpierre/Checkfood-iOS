//
//  Menu.swift
//  Checkfood
//
//  Created by Felipe Umpierre on 15/10/15.
//  Copyright © 2015 Felipe Umpierre. All rights reserved.
//

import Foundation

class Product {
    var id: Int
    var name: String
    var description: String
    var price: Double
    
    var ingredients: [Ingredient]?
    var quantity: Int?
    var observation: String?
    
    init(id: Int, name: String, description: String, price: Double) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
    }
    
    func ingredientList() -> String {
        var arrayOfIngredients: [String] = [String]()
        
        for ingredient in self.ingredients! {
            arrayOfIngredients.append(ingredient.name)
        }
        
        return arrayOfIngredients.joinWithSeparator(", ")
    }
}