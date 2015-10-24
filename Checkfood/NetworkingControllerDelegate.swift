//
//  NetworkingControllerDelegate.swift
//  Checkfood
//
//  Created by Felipe Umpierre on 24/10/15.
//  Copyright © 2015 Felipe Umpierre. All rights reserved.
//

import Foundation

protocol NetworkingControllerDelegate: class {
    func networkingDidUpdate<T>(object: [T])
}

extension NetworkingControllerDelegate {
    func networkingDidUpdate<T>(object: T) {}
}