//
//  Helper.swift
//  Checkfood
//
//  Created by Felipe Umpierre on 24/10/15.
//  Copyright © 2015 Felipe Umpierre. All rights reserved.
//

import UIKit

extension String {
    var twoFractionDigits: String {
        let formatter = NSNumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "pt_BR")
        
        let converter = NSNumberFormatter()
        converter.decimalSeparator = "."
        
        if let result = converter.numberFromString(self) {
            return formatter.stringFromNumber(result)!
        }
        
        return ""
    }
}