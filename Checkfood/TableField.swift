//
//  File.swift
//  Checkfood
//
//  Created by Felipe Umpierre on 31/10/15.
//  Copyright © 2015 Felipe Umpierre. All rights reserved.
//

import Foundation
import SQLite

struct ProductTableField {
    static let productId = Expression<Int64>("productId")
    static let id = Expression<Int64>("id")
    static let name = Expression<String>("name")
    static let descriptive = Expression<String>("descriptive")
    static let price = Expression<Double>("price")
}