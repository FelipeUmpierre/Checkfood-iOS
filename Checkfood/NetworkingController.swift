//
//  NetworkingController.swift
//  Checkfood
//
//  Created by Felipe Umpierre on 24/10/15.
//  Copyright © 2015 Felipe Umpierre. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkingController {
    weak var delegate: NetworkingControllerDelegate?
    
    func makeRequestToApi<T>(create: JSON -> [T], url: String) {
        Alamofire.request(.GET, url).responseJSON { request in
            if let json = request.result.value {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
                    let data = JSON(json)
                    let object: [T] = create(data)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.delegate?.networkingDidUpdate(object)
                    }
                }
            }
        }
    }
    
    func createProductObject(data: JSON) -> [Product] {
        var products: [Product] = []

        for (_, subJson): (String, JSON) in data {
            let product: Product = Product(id: subJson["id"].int!, name: subJson["name"].string!, description: subJson["description"].string!, price: subJson["price"].doubleValue)
            product.ingredients = createIngredientsObject(subJson)

            products += [product]
        }

        return products
    }
    
    func createIngredientsObject(data: JSON) -> [Ingredient] {
        var ingredients: [Ingredient] = []
        
        for (_, ingredient): (String, JSON) in data["ingredients"] {
            ingredients += [Ingredient.init(id: ingredient["id"].int!, name: ingredient["name"].string!)]
        }
        
        return ingredients
    }
}