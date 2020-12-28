// I, Prerak Patel, student number 000825410, certify that this material is my original work. No other person's work has been used without due acknowledgement and I have not made my work available to anyone else.

//  TemperatureViewController.swift
//  Converter
//
//  Created by Prerak Patel on 2020-10-06.
//  Copyright © 2020 Mohawk College. All rights reserved.
//

import UIKit

class TemperatureViewController: UIViewController {

    // temperatureTextField is outlet variable for the
    // Text Field at the top to get the input from the user
    @IBOutlet var temperatureTextField: UITextField!
    
    // temperatureOutputLabel is outlet variable for the
    // Output Label below the buttons to display results to the user
    @IBOutlet var temperatureOutputLabel: UILabel!
    
    // temperatureInputValue variable to store the input
    // value from the user
    var temperatureInputValue: Double?
    
    // celsiusInput is a variable with Measurement unit type temperature
    // to store the input from the user as Celsius unit
    var celsiusInput: Measurement<UnitTemperature>?
    
    // farhenheitValue is a variable with Measurement unit type temperature
    // to return the farhenheit value from the celsiusInput value
    var farhenheitValue: Measurement<UnitTemperature>? {
        if let celsiusInput = celsiusInput {
            return celsiusInput.converted(to: .fahrenheit)
        } else {
            return nil
        }
    }
    
    // farhenheitInput is a variable with Measurement unit type temperature
    // to store the input from the user as Farhenheit unit
    var farhenheitInput: Measurement<UnitTemperature>?
    
    // celsiusValue is a variable with Measurement unit type temperature
    // to return the celsius value from the farhenheitInput value
    var celsiusValue: Measurement<UnitTemperature>? {
        if let farhenheitInput = farhenheitInput {
            return farhenheitInput.converted(to: .celsius)
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
        temperatureTextField.resignFirstResponder()
    }
    
    // -------EXTRAS---------
    // temperatureEditTextFieldChanged function uses Text Field Changed Action to sense
    // if the user makes any changes to the Text Field we can make the Output label disappear
    // so that user can find it more user-friendly
    @IBAction func temperatureEditTextFieldChanged( temperatureTextField: UITextField) {
        temperatureOutputLabel.text = nil
    }
    
    // celsiusToFarhenheitButton function is a "TOUCH UP INSIDE" listener for °C to °F Button
    @IBAction func celsiusToFarhenheitButton() {
        
        // Optional binding to check if the Text Field has the value and if it does
        // then we can check if we can convert that into Double
        if let text = temperatureTextField.text, let value = Double(text) {
            // storing the input Text Field value which has confirmed Double value
            temperatureInputValue = value
            // celsiusInput is holding Measurement unit Type temperature Celsius value
            celsiusInput = Measurement(value: value, unit: .celsius)
        } else {
            // storing the nil value in celsiusInput if the input Text Field does not hold valid input
            celsiusInput = nil
        }
        
        // Optional binding to check if the farhenheitValue holds the converted value from the celsius
        // and handle gracefully if the celsiusInput value is nil due to which farhenheit value will also be nil
        if let farhenheitValue = farhenheitValue {
            // printing out the converted value if the farhenheit value has the value
            temperatureOutputLabel.text = numberFormatter.string(from: NSNumber(value: temperatureInputValue!))! + "℃ is " + numberFormatter.string(from: NSNumber(value: farhenheitValue.value))! + "℉"
        } else {
            // handling gracefully if the celsiusInput has the wrong input by priting out the error
            temperatureOutputLabel.text = "Unable to convert " + temperatureTextField.text!
        }
    }
    
    // farhenheitToCelsiusButton function is a "TOUCH UP INSIDE" listener for °F to °C Button
    @IBAction func farhenheitToCelsiusButton() {
        
        // Optional binding to check if the Text Field has the value and if it does
        // then we can check if we can convert that into Double
        if let text = temperatureTextField.text, let value = Double(text) {
            // storing the input Text Field value which has confirmed Double value
            temperatureInputValue = value
            // farhenheitInput is holding Measurement unit Type temperature Fahrenheit value
            farhenheitInput = Measurement(value: value, unit: .fahrenheit)
        } else {
            // storing the nil value in farhenheitInput if the input Text Field does not hold valid input
            farhenheitInput = nil
        }
        
        // Optional binding to check if the celsiusValue holds the converted value from the farhenheit
        // and handle gracefully if the farhenheitInput value is nil due to which celsius value will also be nil
        if let celsiusValue = celsiusValue {
            temperatureOutputLabel.text = numberFormatter.string(from: NSNumber(value: temperatureInputValue!))! + "℉ is " + numberFormatter.string(from: NSNumber(value: celsiusValue.value))! + "℃"
        } else {
            // handling gracefully if the farhenheitInput has the wrong input by priting out the error
            temperatureOutputLabel.text = "Unable to convert " + temperatureTextField.text!
        }
    }
}

