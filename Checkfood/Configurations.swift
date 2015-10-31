//
//  Configurations.swift
//  Checkfood
//
//  Created by Felipe Umpierre on 31/10/15.
//  Copyright © 2015 Felipe Umpierre. All rights reserved.
//

import Foundation
import SQLite

class Configurations {
    let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
    var db: Connection?
    
    // MARK: - Initializer
    
    init() {
        self.db = try! Connection("\(self.path)/db.sqlite3")
    }
    
    // MARK: - Database Actions
    
    func insert(insert: SQLite.Insert) {
        try! self.db!.run(insert)
    }
    
    func update(update: SQLite.Update) {
        try! self.db!.run(update)
    }
    
    func delete(table: String) {
        try! self.db!.run(Table(table).delete())
    }
    
    func delete(object: SQLite.QueryType) {
        try! self.db!.run(object.delete())
    }
    
    // MARK: - Creating table
    
    func createTable(table: String) {
        try! self.db!.run(Table(table).create(ifNotExists: true) { t in
            t.column(ProductTableField.productId, primaryKey: true)
            t.column(ProductTableField.id)
            t.column(ProductTableField.name)
            t.column(ProductTableField.descriptive)
            t.column(ProductTableField.price)
        })
    }
}