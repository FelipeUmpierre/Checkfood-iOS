//
//  DataFile.swift
//  Checkfood
//
//  Created by Felipe Umpierre on 27/10/15.
//  Copyright © 2015 Felipe Umpierre. All rights reserved.
//

import Foundation

class DataFile {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    func saveToFile<T>(object: [T], key: String) {
        
        var array: [T] = object
        
        if let load: [T] = loadFromFile(key) {
            array += load
        }
        
        let encodedData = NSKeyedArchiver.archivedDataWithRootObject(array as! AnyObject)
        
        self.userDefaults.setObject(encodedData, forKey: key)
        self.userDefaults.synchronize()
    }
    
    func loadFromFile<T>(key: String) -> [T]? {
        let decoded = self.userDefaults.objectForKey(key) as! NSData
        
        if let decodedProducts = NSKeyedUnarchiver.unarchiveObjectWithData(decoded) as? [T] {
            return decodedProducts
        }
        
        return nil
    }
}