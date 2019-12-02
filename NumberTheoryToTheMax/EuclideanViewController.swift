//
//  EuclideanViewController.swift
//  NumberTheoryToTheMax
//
//  Created by Jonah Zukosky on 11/18/19.
//  Copyright © 2019 Zukosky, Jonah. All rights reserved.
//

import UIKit

class EuclideanViewController: UIViewController {

    @IBOutlet weak var num1Field: UITextField!
    @IBOutlet weak var num2Field: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateButton.layer.cornerRadius = 5
        calculateButton.titleLabel?.textAlignment = NSTextAlignment.center
        textView.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    @IBAction func calculateButtonPressed(_ sender: Any) {
        textView.text = ""
        if(num1Field.text == "" || num2Field.text == ""){
            //if we are missing an input present an alert
            let alert = UIAlertController(title: "Please enter a number in both fields", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)

        }else{
            //this may need some work yikes
            let a = Int(num1Field.text ?? "0")
            let b = Int(num2Field.text ?? "0")
            let gcd = euclid(num1: UInt64(a!), num2: UInt64(b!))
            textView.text += "GCD: \(gcd)"
            
            let bottom = NSMakeRange(textView.text.count - 1, 1)
            textView.scrollRangeToVisible(bottom)
            num1Field.resignFirstResponder()
            num2Field.resignFirstResponder()
        }
    }
    
    func euclid(num1 : UInt64, num2: UInt64) -> UInt64{
        var prevRemainder : UInt64
        var a : UInt64
        var b : UInt64
        
        //want a > b
        if(num1 >= num2){
            a = num1
            b = num2
        } else {
            b = num1
            a = num2
        }
        
        var remainder : UInt64
        remainder = 1
        prevRemainder = b
        
        while(remainder != 0){
            let quotient = a/b
            remainder = a % b
             textView.text += ("\(a) =  \(b) (\(quotient)) + \(remainder)\n")
            
            if(remainder != 0){
                prevRemainder = remainder
            }
            
            a = b
            b = remainder
        }
        //returning the GCD
        return prevRemainder
    }

}
