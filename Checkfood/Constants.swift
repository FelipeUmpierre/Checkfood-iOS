//
//  Constants.swift
//  Checkfood
//
//  Created by Felipe Umpierre on 15/10/15.
//  Copyright © 2015 Felipe Umpierre. All rights reserved.
//

import Foundation

struct Urls {
    static let main = "http://api-checkfood.rhcloud.com/api"
    static let menu = Urls.main + "/menu"
    static let productDetail = Urls.main + "/product"
    static let orderRequest = Urls.main + "/order/board/"
}

struct Segues {
    static let ProductDetailSegue = "ProductDetailSegue"
    static let ObservationDetailSegue = "ObservationProductSegue"
    static let CartProductSegue = "CartProductSegue"
}

struct CellReuse {
    static let CellReuseProductIdentifier = "Product"
    static let CellReuseCartIdentifier = "Cart"
}

struct NotificationsKey {
    static let NotificationsMenuKey = "notificationKeyForMenu"
    static let NotificationsProductDetailKey = "notificationKeyForProductDetail"
}

struct NSUserDefaultsKey {
    static let NSUserDefaultsKeyForCart = "NSUserDefaultsKeyCart"
}

struct NSArchiverPath {
    static let archiverProducts = "archiverProducts"
}