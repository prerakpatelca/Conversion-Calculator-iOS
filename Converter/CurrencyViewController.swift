// I, Prerak Patel, student number 000825410, certify that this material is my original work. No other person's work has been used without due acknowledgement and I have not made my work available to anyone else.

//  CurrencyViewController.swift
//  Converter
//
//  Created by Prerak Patel on 2020-10-06.
//  Copyright © 2020 Mohawk College. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {

    // currencyTextField is outlet variable for the
    // Text Field at the top to get the input from the user
    @IBOutlet var currencyTextField: UITextField!
    
    // currencyOutputLabel is outlet variable for the
    // Output Label below the buttons to display results to the user
    @IBOutlet var currencyOutputLabel: UILabel!
    
    // numberFormatter is a variable for the Number formmater class
    // to format the minimum and maximum fraction digits
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    // default method runs when application starts
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // clickAwayToDismissKeyboard function uses Tap Gesture Recognizer to sense
    // if the user clicks away from the TextField we can make the keyboard disappear
    @IBAction func clickAwayToDismissKeyboard(_ sender: UITapGestureRecognizer) {
        currencyTextField.resignFirstResponder()
    }
    
    // -------EXTRAS---------
    // currencyEditTextFieldChanged function uses Text Field Changed Action to sense
    // if the user makes any changes to the Text Field we can make the Output label disappear
    // so that user can find it more user-friendly
    @IBAction func currencyEditTextFieldChanged(currencyTextField: UITextField) {
         currencyOutputLabel.text = nil
    }
    
    // cadToUsDollarsButton function is a "TOUCH UP INSIDE" listener for CAD to USD Button
    @IBAction func cadToUsDollarsButton() {
        
        // Optional binding to check if the Text Field has the value and if it does
        // then we can check if we can convert that into Double
        if let text = currencyTextField.text, let value = Double(text) {
            // printing out the converted value for the CAD to USD
            currencyOutputLabel.text = "$" + numberFormatter.string(from: NSNumber(value: Double(text)!))! + " CAD is $" + numberFormatter.string(from: NSNumber(value: value * 0.746897))! + " USD"
        } else {
            // handling gracefully if the currencyTextField has the wrong input by priting out the error
            currencyOutputLabel.text = "Unable to convert " + currencyTextField.text!
        }
    }
    
    // cadToUsDollarsButton function is a "TOUCH UP INSIDE" listener for USD to CAD Button
    @IBAction func usdToCadDollarsButton() {
        
        // Optional binding to check if the Text Field has the value and if it does
        // then we can check if we can convert that into Double
        if let text = currencyTextField.text, let value = Double(text) {
            // printing out the converted value for the USD to CAD
            currencyOutputLabel.text = "$" + text + " USD is $" + numberFormatter.string(from: NSNumber(value: value / 0.746897))! + " CAD"
        } else {
            // handling gracefully if the currencyTextField has the wrong input by priting out the error
            currencyOutputLabel.text = "Unable to convert " + currencyTextField.text!
        }
    }
}

