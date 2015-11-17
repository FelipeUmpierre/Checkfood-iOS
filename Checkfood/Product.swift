//
//  Menu.swift
//  Checkfood
//
//  Created by Felipe Umpierre on 15/10/15.
//  Copyright © 2015 Felipe Umpierre. All rights reserved.
//

import Foundation

class Product {
    
    // MARK: - Property
    
    var id: Int
    var name: String
    var descriptive: String
    var price: Double
    
    var ingredients: [Ingredient]?
    var quantity: Int?
    var observation: String?
    
    // MARK: - init
    
    init(id: Int, name: String, description: String, price: Double, ingredients: [Ingredient]? = [], quantity: Int? = 1, observation: String? = "") {
        self.id = id
        self.name = name
        self.descriptive = description
        self.price = price
        self.ingredients = ingredients
        self.quantity = quantity
        self.observation = observation
    }
    
    // MARK: - Converting Array to String
    
    func ingredientList() -> String {
        var arrayOfIngredients: [String] = [String]()
        
        for ingredient in self.ingredients! {
            arrayOfIngredients.append(ingredient.name)
        }
        
        return arrayOfIngredients.joinWithSeparator(", ")
    }
}