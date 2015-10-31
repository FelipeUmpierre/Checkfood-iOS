//
//  CartTableViewController.swift
//  Checkfood
//
//  Created by Felipe Umpierre on 20/10/15.
//  Copyright © 2015 Felipe Umpierre. All rights reserved.
//

import UIKit

class CartTableViewController: UITableViewController {
    
    var products: [Product] = []
    let configurations: Configurations = Configurations();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProductsToListOrder()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        loadProductsToListOrder()
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
        
        if let productSubtitleDescriptive = cell.viewWithTag(2) as? UILabel {
            productSubtitleDescriptive.text = product.descriptive
        }
        
        if let productPrice = cell.viewWithTag(3) as? UILabel {
            productPrice.text = "\(product.price)".twoFractionDigits
        }
        
        return cell
    }
    
    @IBAction func cleanListOfProducts(sender: AnyObject) {
        self.configurations.delete("product")
        
        self.tableView.reloadData()
    }
    
    func loadProductsToListOrder() {
        self.products = ProductDatabase.listProduct(self.configurations.db!)
        
        self.tableView.reloadData()
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if let product: Product = self.products[indexPath.row] {
                //self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                self.configurations.delete(ProductDatabase.deleteProduct(product))
            }
            
            loadProductsToListOrder()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
