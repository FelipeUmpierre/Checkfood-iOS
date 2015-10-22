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

        Alamofire.request(.GET, getFullProductDetailUrl()).responseJSON { request in
            if let json = request.result.value {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
                    let data = JSON(json)
                    var ingredients: [Ingredient] = []
                    
                    for (_, ingredient): (String, JSON) in data["ingredients"] {
                        ingredients += [Ingredient.init(id: ingredient["id"].int!, name: ingredient["name"].string!)]
                    }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.product?.ingredients = ingredients
                        self.loadViewComponents()
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func getFullProductDetailUrl() -> String {
        return  "\(Urls.productDetail)/\(self.product!.id)"
    }
    
    // MARK: - Load Components
    
    private func loadViewComponents() {
        productNameLabel.text = self.product!.name
        productPriceLabel.text = "\(self.product!.price)"
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
