//
//  CartTableViewController.swift
//  Checkfood
//
//  Created by Felipe Umpierre on 20/10/15.
//  Copyright © 2015 Felipe Umpierre. All rights reserved.
//

import UIKit
import SwiftyJSON
import JLToast

class CartTableViewController: UITableViewController, NetworkingControllerDelegate {
    
    var products: [Product] = []
    let configurations = Configurations();
    let networkingController = NetworkingController()
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProductsToListOrder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        loadProductsToListOrder()
    }
    
    // MARK: - NetworkingControllerDelegate
    
    func networkingMessageUpdate(object: JSON) {
        if object["message"].isExists() {
            JLToast.makeText(object["message"].string!, duration: JLToastDelay.ShortDelay).show()
            
            removeProductsFromList()
            self.tabBarController?.selectedIndex = 0
        }
        
        LoadingOverlay.shared.hideOverlayView()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellReuse.CellReuseCartIdentifier, forIndexPath: indexPath)
        let product = self.products[indexPath.row]

        if let productTitleName = cell.viewWithTag(1) as? UILabel {
            productTitleName.text = product.name
        }
        
        /**
         * removed the descriptive of the product in the cart
         *
         * if let productSubtitleDescriptive = cell.viewWithTag(2) as? UILabel {
         *     productSubtitleDescriptive.text = product.descriptive
         * }
         */
        
        if let productPrice = cell.viewWithTag(3) as? UILabel {
            let totalPrice = product.price * Double(product.quantity!)
            
            productPrice.text = "\(totalPrice)".twoFractionDigits
        }
        
        if let productQuantity = cell.viewWithTag(4) as? UILabel {
            productQuantity.text = "\(product.quantity!)x"
        }
        
        return cell
    }
    
    // MARK: - Product functions
    
    func loadProductsToListOrder() {
        self.products = ProductDatabase.listProduct(self.configurations.db!)

        self.tableView.reloadData()
    }
    
    func removeProductsFromList() {
        self.configurations.delete("product")
    }
    
    // MARK: - Actions
    
    @IBAction func cleanListOfProducts(sender: AnyObject) {
        removeProductsFromList()
        loadProductsToListOrder()
    }
    
    @IBAction func finishOrderRequest(sender: AnyObject) {
        LoadingOverlay.shared.showOverlay(self.navigationController?.view)
        
        if self.products.count > 0 {
            networkingController.delegate = self
            networkingController.sendRequestToOrder(1, products: self.products)
        } else {
            JLToast.makeText("No product to order.", duration: JLToastDelay.ShortDelay).show()
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            self.configurations.delete(ProductDatabase.findOne(self.products[indexPath.row]))
            self.products.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}
