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

class MenuViewController: UITableViewController, NetworkingControllerDelegate {

    var products: [Product] = []
    let networkingController = NetworkingController()
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkingController.delegate = self
        networkingController.makeRequestToApi(networkingController.createProductObject, url: Urls.menu)
        
        LoadingOverlay.shared.showOverlay(self.navigationController?.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - NetworkingControllerDelegate
    
    func networkingDidUpdate<T>(object: [T]) {
        self.products = object as Any as! [Product]
        self.tableView.reloadData()
            
        LoadingOverlay.shared.hideOverlayView()
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
