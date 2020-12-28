// I, Prerak Patel, student number 000825410, certify that this material is my original work. No other person's work has been used without due acknowledgement and I have not made my work available to anyone else.

//  DistanceViewController.swift
//  Converter
//
//  Created by Prerak Patel on 2020-10-06.
//  Copyright © 2020 Mohawk College. All rights reserved.
//

import UIKit

class DistanceViewController: UIViewController {

    // distanceTextField is outlet variable for the
    // Text Field at the top to get the input from the user
    @IBOutlet var distanceTextField: UITextField!
    
    // distanceOutputLabel is outlet variable for the
    // Output Label below the buttons to display results to the user
    @IBOutlet var distanceOutputLabel: UILabel!
    
    // distanceInputValue variable to store the input
    // value from the user
    var distanceInputValue: Double?
    
    // kilometersInput is a variable with Measurement unit type length
    // to store the input from the user as kilometers unit
    var kilometersInput: Measurement<UnitLength>?
    
    // milesValue is a variable with Measurement unit type length
    // to return the miles value from the milesInput value
    var milesValue: Measurement<UnitLength>? {
        if let kilometersInput = kilometersInput {
            return kilometersInput.converted(to: .miles)
        } else {
            return nil
        }
    }
    
    // milesInput is a variable with Measurement unit type length
    // to store the input from the user as miles unit
    var milesInput: Measurement<UnitLength>?
    
    // kilometersValue is a variable with Measurement unit type length
    // to return the kilometers value from the milesInput value
    var kilometersValue: Measurement<UnitLength>? {
        if let milesInput = milesInput {
            return milesInput.converted(to: .kilometers)
        } else {
            return nil
        }
    }
    
    // numberFormatter is a variable for the Number formmater class
    // to format the minimum and maximum fraction digits
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 1
        nf.maximumFractionDigits = 1
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
        distanceTextField.resignFirstResponder()
    }
    
    // -------EXTRAS---------
    // distanceEditTextFieldChanged function uses Text Field Changed Action to sense
    // if the user makes any changes to the Text Field we can make the Output label disappear
    // so that user can find it more user-friendly
    @IBAction func distanceEditTextFieldChanged() {
        distanceOutputLabel.text = nil
    }
    
    // kilometersToMilesButton function is a "TOUCH UP INSIDE" listener for KM to Miles Button
    @IBAction func kilometersToMilesButton() {
        
        // Optional binding to check if the Text Field has the value and if it does
        // then we can check if we can convert that into Double
        if let text = distanceTextField.text, let value = Double(text) {
            // storing the input Text Field value which has confirmed Double value
            distanceInputValue = value
            // kilometersInput is holding Measurement unit Type length kilometers value
            kilometersInput = Measurement(value: value, unit: .kilometers)
        } else {
            // storing the nil value in kilometersInput if the input Text Field does not hold valid input
            kilometersInput = nil
        }
        
        // Optional binding to check if the milesValue holds the converted value from the kilometers
        // and handle gracefully if the kilometersInput value is nil due to which miles value will also be nil
        if let milesValue = milesValue {
            // printing out the converted value if the miles value has the value
            distanceOutputLabel.text = numberFormatter.string(from: NSNumber(value: distanceInputValue!))! + " KM is " + numberFormatter.string(from: NSNumber(value: milesValue.value))! + " Miles"
        } else {
            // handling gracefully if the kilometersInput has the wrong input by priting out the error
            distanceOutputLabel.text = "Unable to convert " + distanceTextField.text!
        }
    }
    
    // milesToKilometersButton function is a "TOUCH UP INSIDE" listener for Miles to KM Button
    @IBAction func milesToKilometersButton() {
        if let text = distanceTextField.text, let value = Double(text) {
            // storing the input Text Field value which has confirmed Double value
            distanceInputValue = value
            // milesInput is holding Measurement unit Type length miles value
            milesInput = Measurement(value: value, unit: .miles)
        } else {
           milesInput = nil
        }
        
        if let kilometersValue = kilometersValue {
            // printing out the converted value if the kilometers value has the value
            distanceOutputLabel.text = numberFormatter.string(from: NSNumber(value: distanceInputValue!))! + " Miles is " + numberFormatter.string(from: NSNumber(value: kilometersValue.value))! + " KM"
        } else {
            // handling gracefully if the milesInput has the wrong input by priting out the error
            distanceOutputLabel.text = "Unable to convert " + distanceTextField.text!
        }
    }
}
