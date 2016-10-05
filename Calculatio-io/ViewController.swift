//
//  ViewController.swift
//  Calculatio-io
//
//  Created by Phuong Nguyen Viet on 05/10/2016.
//  Copyright © 2016 Phuong Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    var defaults = UserDefaults.standard
    var percList:[Double] = []
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        percList = defaults.array(forKey: "percentageList") as! [Double]
        
        print(percList.count)
        
        if percList.count == 0 {
            percList = [0.1, 0.15, 0.2]
            defaults.setValue(percList, forKey: "percentageList")
            calculateTip(self)
        } else {
            for (index, value) in percList.enumerated() {
                tipControl.setTitle("\(String(format:"%.0f",value*100))%", forSegmentAt: index)
                calculateTip(self)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        for i in percList {
            print("#\(i)")
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did dissapear")
    }

    @IBAction func onFinishEditing(_ sender: AnyObject) {
        print("Hello2")
        billField.text = getCurrency(amount: Double(billField.text!) ?? 0)
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        let billAmt = getDouble(amount: billField.text!, CurrencyOrPercetage: "C")
        let tipAmt = billAmt * percList[tipControl.selectedSegmentIndex]
        let totalAmt = billAmt + tipAmt
        
        
        tipLabel.text = getCurrency(amount: tipAmt)
        totalLabel.text = getCurrency(amount: totalAmt)
        print(getCurrency(amount: totalAmt))
    }
    
    public func getCurrency (amount: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = NSLocale.current
        
        let input = amount as NSNumber
        let output = currencyFormatter.string(from: input)
        return output!
    }
    
    public func getDouble (amount: String, CurrencyOrPercetage: String) -> Double {
        let doubleFormatter = NumberFormatter()
        var output = Double()
        
        if (amount == "" || amount == ".") {
            output = 0.0
        } else if (Double(amount) ?? -1) != -1 {
            output = Double(amount)!
        } else if CurrencyOrPercetage == "P" {
            doubleFormatter.numberStyle = .percent
            output = doubleFormatter.number(from: amount) as! Double
        } else if CurrencyOrPercetage == "C" {
            doubleFormatter.numberStyle = .currency
            doubleFormatter.locale = NSLocale.current
            
            output = doubleFormatter.number(from: amount) as! Double
        }
        return output
    }
}
