//
//  ProductDatabase.swift
//  Checkfood
//
//  Created by Felipe Umpierre on 31/10/15.
//  Copyright © 2015 Felipe Umpierre. All rights reserved.
//

import Foundation
import SQLite

struct ProductDatabase {
    static func insertProduct(product: Product) -> SQLite.Insert {
        return Table("product").insert(ProductTableField.id <- Int64(product.id), ProductTableField.name <- product.name, ProductTableField.descriptive <- product.descriptive, ProductTableField.price <- product.price)
    }
    
    static func updateProduct(product: Product) -> SQLite.Update {
        return Table("product").update(ProductTableField.name <- product.name, ProductTableField.descriptive <- product.descriptive, ProductTableField.price <- product.price)
    }
    
    static func deleteProduct(product: Product) -> SQLite.QueryType {
        return Table("product").filter(ProductTableField.id == Int64(product.id))
    }
    
    static func listProduct(db: Connection) -> [Product] {
        let table: Table = Table("product")
        var productArray: [Product] = []
        
        for product in db.prepare(table) {
            productArray += [Product(id: Int(product[ProductTableField.id]), name: product[ProductTableField.name], description: product[ProductTableField.descriptive], price: product[ProductTableField.price])]
        }
        
        return productArray
    }
}