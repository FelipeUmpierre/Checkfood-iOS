//
//  MenuViewController.swift
//  Checkfood
//
//  Created by Felipe Umpierre on 16/10/15.
//  Copyright © 2015 Felipe Umpierre. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MenuViewControlvar: UITableViewController {

    var products: [Product] = []
    let menu: Menu = Menu()
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadingOverlay.shared.showOverlay(self.navigationController?.view)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableViewData", name: NotificationsKey.NotificationsMenuKey, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - UITableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellReuse.CellReuseProductIdentifier, forIndexPath: indexPath)
        let product = self.products[indexPath.row]
        
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = product.description
        
        return cell
    }
    
    // MARK: - Reload Table View
    
    func reloadTableViewData() {
        self.products = menu.getProducts()!
        self.tableView.reloadData()
        
        LoadingOverlay.shared.hideOverlayView()
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Segues.ProductDetailSegue {
            if let destination = segue.destinationViewController as? DetailsViewController {
                if let productIndex = tableView.indexPathForSelectedRow?.row {
                    destination.product = self.products[productIndex]
                }
            }
        }
    }

}
