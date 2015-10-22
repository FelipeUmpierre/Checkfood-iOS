//
//  ObservationViewController.swift
//  Checkfood
//
//  Created by Felipe Umpierre on 20/10/15.
//  Copyright © 2015 Felipe Umpierre. All rights reserved.
//

import UIKit

class ObservationViewController: UIViewController {
    
    var product: Product?

    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var observationTextView: UITextView!
    
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
    
    @IBAction func stepperUpdateTextField(sender: UIStepper) {
        self.quantityTextField.text = Int(sender.value).description
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Segues.CartProductSegue {
            if let destination = segue.destinationViewController as? CartTableViewController {
                self.product!.quantity = Int(quantityTextField.text!)
                self.product!.observation = observationTextView.text
                
                destination.products += [self.product]
            }
        }
        
    }
}