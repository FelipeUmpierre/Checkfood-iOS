//
//  Menu.swift
//  Checkfood
//
//  Created by Felipe Umpierre on 17/10/15.
//  Copyright © 2015 Felipe Umpierre. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Menu {
    var products: [Product] = []
    
    init() {
        Alamofire.request(.GET, Urls.menu).responseJSON { request in
            if let json = request.result.value {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
                    let data = JSON(json)
                    var product: [Product] = []
                    
                    for (_, subJson): (String, JSON) in data {
                         product += [Product(id: subJson["id"].int!, name: subJson["name"].string!, description: subJson["description"].string!, price: subJson["price"].doubleValue)]
                    }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.products += product
                        print(self.products)
                        
                        NSNotificationCenter.defaultCenter().addObserver(self, selector: "done", name: NotificationsKey.NotificationsMenuKey, object: nil)
                    }
                }
            }
        }
    }
    
    func totalOfProducts() -> Int {
        return self.products.count
    }
    
    func getProducts() -> [Product]? {
        return self.products
    }
    
    func getProductFromIndex(index: Int) -> Product {
        return self.products[index]
    }
    
    func done() {
        print("aqui no menu model foi")
    }
}