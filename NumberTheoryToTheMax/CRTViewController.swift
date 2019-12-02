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
        //cell.num1TextField.description = "\(indexPath.row)1"
        cell.num2TextField.tag = 1

        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("They just selected row \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addNewLine(_ sender: Any) {
        entryCounts.append(InputObject(first: 0, second: 0))
        textFieldTagCount += 1
        CRTableView.reloadData()
    }
    
    @IBAction func calculateButtonPressed(_ sender: Any) {
        //check that every cell has 2 numbers & clear out arrays
        var array1 = [Int]()
        var array2 = [Int]()
        
        for pair in entryCounts {
            if pair.second == 0 {
                let alert = UIAlertController(title: "n mod 0 is undefined", message: "Please make sure that you have a value entered for all relevant fields.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
            
            array1.append(pair.first)
            array2.append(pair.second)
        }
        //get all the numbers from the table view into arrays
        
        calculateCRT(array1, array2)
        
        
    }
    
    func calculateCRT(_ array1: [Int],_ array2: [Int]){
        print("calculating CRT")
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
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
}


struct InputObject {
    var first: Int
    var second: Int
}
