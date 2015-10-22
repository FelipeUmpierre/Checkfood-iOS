//
//  ProductDetail.swift
//  Checkfood
//
//  Created by Felipe Umpierre on 22/10/15.
//  Copyright © 2015 Felipe Umpierre. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ProductDetail {
    var product: Product? {
        didSet {
            self.find()
        }
    }
    
    func find() {
        let productDetailUrl = "\(Urls.productDetail)/\(self.product!.id)"
        
        Alamofire.request(.GET, productDetailUrl).responseJSON { request in
            if let json = request.result.value {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
                    let data = JSON(json)
                    var ingredients: [Ingredient] = []
                    
                    for (_, ingredient): (String, JSON) in data["ingredients"] {
                        ingredients += [Ingredient.init(id: ingredient["id"].int!, name: ingredient["name"].string!)]
                    }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.product!.ingredients = ingredients
                        
                        NSNotificationCenter.defaultCenter().postNotificationName(NotificationsKey.NotificationsProductDetailKey, object: nil)
                    }
                }
            }
        }
    }
    
    func getProduct() -> Product {
        return self.product!
    }
}