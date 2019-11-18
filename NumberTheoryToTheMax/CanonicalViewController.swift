//
//  CanonicalViewController.swift
//  NumberTheoryToTheMax
//
//  Created by Jonah Zukosky on 11/18/19.
//  Copyright © 2019 Zukosky, Jonah. All rights reserved.
//

import UIKit

class CanonicalViewController: UIViewController {

    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var clipboardButton: UIButton!
    
    var nonAttributedAnswer = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clipboardButton.isHidden = true
//        inputField.clearButtonMode = UITextField.ViewMode.whileEditing
        // Do any additional setup after loading the view.
    }
    
    @IBAction func inputChanged(_ sender: Any) {
        nonAttributedAnswer.removeAll()
        if let input = inputField.text {
            if input == "" {
                outputLabel.text = ""
                clipboardButton.isHidden = true
            } else {
                clipboardButton.isHidden = false
                let number = Int(input)
                if let number = number {
                    let answer = primeFactors(number)
                    let answerString = NSMutableAttributedString()
                    for string in answer {
                        var combinedString = NSMutableAttributedString()
                        if answer.first != string {
                            combinedString = NSMutableAttributedString(string: "* ")
                        }
                        
                        combinedString.append(string)
                        combinedString.append(NSMutableAttributedString(string: " "))
                        answerString.append(combinedString)
                    }
                    outputLabel.attributedText = answerString
                }
            }

            
        } else {
            outputLabel.text = ""
            clipboardButton.isHidden = true
        }
        
    }
    
    func primeFactors(_ n: Int) -> [NSMutableAttributedString] {
        var n = n
        var factors = [Int]()

        var divisor = 2
        while divisor * divisor <= n {
            while n % divisor == 0 {
                factors.append(divisor)
                n /= divisor
            }
            divisor += divisor == 2 ? 1 : 2
        }
        if n > 1 {
            factors.append(n)
        }
        
        var counts = [Int:Int]()
        var filteredFactors = [Int]()
        
        for integer in factors {
            if let seen = counts[integer] {
                counts[integer] = seen + 1
            } else {
                counts[integer] = 1
                filteredFactors.append(integer)
            }
        }
        
        var stringFactors = [NSMutableAttributedString]()
        
        for integer in filteredFactors {
            if let exponent = counts[integer] {
                let string = "\(integer)^\(exponent) "
                let attributedString = addSuperScript(to: string)
                stringFactors.append(attributedString)
                nonAttributedAnswer.append(string)
            }
        }

        return stringFactors
    }
    
    func addSuperScript(to string: String) -> NSMutableAttributedString {
        print(string)
        let exponent = Character("^")
        var duplicateString = string
        if let index = string.firstIndex(of: exponent) {
            print("Found exponent sign")
            let nextIndex = string.index(after: index)
            if string[nextIndex] == "1" {
                print("Next index is 1")
                duplicateString.remove(at: nextIndex)
                duplicateString.remove(at: index)
                
                print(duplicateString)
                return NSMutableAttributedString(string: duplicateString)
                
            }
            
            let intIndex = index.utf16Offset(in: string)
            duplicateString.remove(at: index)
            let range = NSRange(location: intIndex, length: duplicateString.count-1-intIndex)
            
            let fontSuper:UIFont? = UIFont.systemFont(ofSize: 25)
            
            let attributedString = NSMutableAttributedString(string: duplicateString)
            attributedString.setAttributes([NSAttributedString.Key.font:fontSuper!,.baselineOffset:17], range: range)

            return attributedString
        }
        else {
            return NSMutableAttributedString(string: string)
        }
    }
    @IBAction func copyToClipboard(_ sender: Any) {
        UIPasteboard.general.string = nonAttributedAnswer.joined(separator: "* ")
    }
    
}

extension UITextField {
    @objc func modifyClearButton(with image : UIImage) {
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(image, for: .normal)
        clearButton.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(UITextField.clear(_:)), for: .touchUpInside)
        rightView = clearButton
        rightViewMode = .whileEditing
    }

    @objc func clear(_ sender : AnyObject) {
    if delegate?.textFieldShouldClear?(self) == true {
        self.text = ""
        sendActions(for: .editingChanged)
    }
}
}
