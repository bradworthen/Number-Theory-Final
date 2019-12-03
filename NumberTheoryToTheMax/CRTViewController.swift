//
//  CRTViewController.swift
//  NumberTheoryToTheMax
//
//  Created by Jonah Zukosky on 11/18/19.
//  Copyright © 2019 Zukosky, Jonah. All rights reserved.
//

import UIKit

class CRTViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var calculateButton: UIButton!
    
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var CRTableView: UITableView!
//    var textFields = [(UITextField, UITextField)]()
    var entryCounts = [InputObject]()
    var textFieldTagCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 

        calculateButton.layer.cornerRadius = 5
        entryCounts.append(InputObject(first: 0, second: 0))
//        let initialTextField1 = UITextField()
//        initialTextField1.tag = 0
//        initialTextField1.delegate = self
//        initialTextField1.keyboardType = .numberPad
//
//        let initialTextField2 = UITextField()
//        initialTextField2.tag = 1
//        initialTextField2.delegate = self
//        initialTextField2.keyboardType = .numberPad
//
//
//        textFields.append((initialTextField1,initialTextField2))
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryCounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "modCell", for: indexPath) as! CRTTableViewCell

        cell.num1TextField.delegate = self
        cell.num2TextField.delegate = self
        
        cell.num1TextField.tag = 0
        cell.num2TextField.tag = 1
        
        if entryCounts[indexPath.row].first == 0 {
            cell.num1TextField.text = ""
        } else {
            cell.num1TextField.text = "\(entryCounts[indexPath.row].first)"
        }
        
        if entryCounts[indexPath.row].second == 0 {
            cell.num2TextField.text = ""
        } else {
            cell.num2TextField.text = "\(entryCounts[indexPath.row].second)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addNewLine(_ sender: Any) {
        if (entryCounts.count <= 20) {
            entryCounts.append(InputObject(first: 0, second: 0))
            CRTableView.reloadData()
        }
    }
    
    @IBAction func calculateButtonPressed(_ sender: Any) {
        var array1 = [Int]()
        var array2 = [Int]()
        var seenPairs = Set<InputObject>()
        
        for pair in entryCounts {
            if pair.second == 0 {
                let alert = UIAlertController(title: "n mod 0 is undefined", message: "Please make sure that you have a value entered for all relevant fields.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
            
            if !seenPairs.contains(pair) {
                array1.append(pair.first)
                array2.append(pair.second)
                seenPairs.insert(pair)
            }
            
        }
        
        calculateCRT(array1, array2)
    }
    
    func calculateCRT(_ arrayBs: [Int],_ arrayMods: [Int]){
        print("calculating CRT")
        print(arrayBs)
        print(arrayMods)
        
        let numEquations = arrayBs.count
        var arrayNs = [Int]()
        var arrayXs = [Int]()
        var arrayProducts = [Int]()
        //var i = 0

        //Fill arrayNs
        for i in 0..<numEquations {
            arrayNs.append(1)
            for j in 0..<numEquations {
                if(i != j) {
                    arrayNs[i] *= arrayMods[j]
                }
            }
        }
        //Fill arrayXs
        var counter = 0
        for i in 0..<numEquations {
            counter = 1
            while((arrayNs[i] * counter) % arrayMods[i] != 1) {
                counter += 1
            }
            arrayXs.append(counter)
        }

        //Fill arrayProducts and calculate N
        var N = 1
        var sumProduct = 0
        for i in 0..<numEquations {
            arrayProducts.append(arrayBs[i] * arrayNs[i] * arrayXs[i])
            sumProduct += arrayProducts[i]
            //calculate N
            N *= arrayMods[i]
        }

        let answer = sumProduct % N
        print("SumProduct: \(sumProduct)")
        print("N: \(N)")
        answerTextView.text = "Answer: \(answer)"
        
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if entryCounts.count > 1 {
            return true
        } else {
            return false
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            entryCounts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath],  with: UITableView.RowAnimation.automatic)
            // remove items from array
        }
    }


}

extension CRTViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        var v : UIView = textField
        repeat { v = v.superview! } while !(v is UITableViewCell)
        let cell = v as! CRTTableViewCell // or UITableViewCell or whatever
        let ip = self.CRTableView.indexPath(for:cell)!
        
        if textField.tag == 0 {
            entryCounts[ip.row].first = Int(textField.text ?? "0") ?? 0
        } else if textField.tag == 1 {
            entryCounts[ip.row].second = Int(textField.text ?? "0") ?? 0
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        var v : UIView = textField
        repeat { v = v.superview! } while !(v is UITableViewCell)
        let cell = v as! CRTTableViewCell // or UITableViewCell or whatever
        let ip = self.CRTableView.indexPath(for:cell)!
        
        if textField.tag == 0 {
            entryCounts[ip.row].first = Int(textField.text ?? "0") ?? 0
        } else if textField.tag == 1 {
            entryCounts[ip.row].second = Int(textField.text ?? "0") ?? 0
        }
    }
}


struct InputObject: Hashable, Equatable {
    var first: Int
    var second: Int
    
    static func == (lhs: InputObject, rhs: InputObject) -> Bool {
        return lhs.first == rhs.first && lhs.second == rhs.second
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
