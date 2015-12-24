//
//  ObservationViewController.swift
//  Checkfood
//
//  Created by Felipe Umpierre on 20/10/15.
//  Copyright © 2015 Felipe Umpierre. All rights reserved.
//

import UIKit
import JLToast

class ObservationViewController: UIViewController {
    
    var product: Product?

    // MARK: - Outlets
    
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var observationTextView: UITextView!
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let borderColor: CGColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).CGColor
        
        // Custom TextView Border
        self.observationTextView.layer.borderWidth = CGFloat(0.5)
        self.observationTextView.layer.borderColor = borderColor
        self.observationTextView.layer.cornerRadius = CGFloat(5.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Actions
    
    @IBAction func stepperUpdateTextField(sender: UIStepper) {
        self.quantityTextField.text = Int(sender.value).description
    }
    
    @IBAction func addProductToCartButton(sender: AnyObject) {
        self.product!.quantity = Int(quantityTextField.text!)
        self.product!.observation = observationTextView.text
        
        let configurations = Configurations();
        configurations.createTable("product")
        
        if let thisProduct: Product = ProductDatabase.createProductRow(configurations.findOne(ProductDatabase.findOne(self.product!))) {
            let quantity = thisProduct.quantity! + self.product!.quantity!
            self.product!.quantity = quantity

            configurations.update(ProductDatabase.updateProduct(self.product!))
        } else {
            configurations.insert(ProductDatabase.insertProduct(self.product!))
        }
        
        JLToast.makeText("Product added with success!", duration: JLToastDelay.ShortDelay).show()
        
        navigationController?.popToRootViewControllerAnimated(true)
    }
}