//
//  DetailsViewController.swift
//  Checkfood
//
//  Created by Felipe Umpierre on 18/10/15.
//  Copyright © 2015 Felipe Umpierre. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailsViewController: UIViewController {

    var product: Product?
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productIngredientsLabel: UILabel!
    @IBOutlet weak var productDescriptionTextView: UITextView!
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadComponents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Load Components
    
    func loadComponents() {
        productNameLabel.text = self.product!.name
        productPriceLabel.text = "\(self.product!.price)".twoFractionDigits
        productIngredientsLabel.text = self.product!.ingredientList()
        productDescriptionTextView.text = self.product!.description
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Segues.ObservationDetailSegue {
            if let destination = segue.destinationViewController as? ObservationViewController {
                destination.product = self.product
            }
        }
    }
}