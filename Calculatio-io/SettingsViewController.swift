//
//  SettingsViewController.swift
//  Calculatio-io
//
//  Created by Phuong Nguyen Viet on 05/10/2016.
//  Copyright © 2016 Phuong Nguyen. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var tipField1: UITextField!
    @IBOutlet weak var tipField2: UITextField!
    @IBOutlet weak var tipField3: UITextField!
    @IBOutlet weak var savedResultLabel: UILabel!
    let defaults = UserDefaults.standard
    var defaultList:[Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        defaultList = defaults.array(forKey: "percentageList") as! [Double]
        
        print(defaultList.count)
        for i in defaultList {
            print("#\(i)")
        }
        tipField1.text = "\(String(format:"%.0f",defaultList[0]*100))%"
        tipField2.text = "\(String(format:"%.0f",defaultList[1]*100))%"
        tipField3.text = "\(String(format:"%.0f",defaultList[2]*100))%"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func saveButton(_ sender: AnyObject) {
        var results: [Double] = []
        
        defaultList.removeAll()
        
        defaultList.append((Double(tipField1.text!.replacingOccurrences(of: "%", with: "")) ?? 0)/100)
        print("Saved: #\(defaultList[0])")
        defaultList.append((Double(tipField2.text!.replacingOccurrences(of: "%", with: "")) ?? 0)/100)
        print("Saved: #\(defaultList[1])")
        defaultList.append((Double(tipField3.text!.replacingOccurrences(of: "%", with: "")) ?? 0)/100)
        print("Saved: #\(defaultList[2])")
        
        
        defaults.removeObject(forKey: "percentageList")
        defaults.setValue(defaultList, forKey: "percentageList")
        
        results = defaults.array(forKey: "percentageList") as! [Double]
        
        var text = "Saved results are:"
        for i in results {
            text += ("\n \(String(format:"%.2f",i*100))%")
        }
        
        print(text)
        savedResultLabel.text = text
    }
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onQuitField1(_ sender: AnyObject) {
        tipField1.text = detectChange(changedValue: tipField1.text!, defaultValue: defaultList[0])
    }
    
    @IBAction func onQuitField2(_ sender: AnyObject) {
        tipField2.text = detectChange(changedValue: tipField2.text!, defaultValue: defaultList[1])
    }
    
    @IBAction func onQuitField3(_ sender: AnyObject) {
        tipField3.text = detectChange(changedValue: tipField3.text!, defaultValue: defaultList[2])
    }
    
    func detectChange(changedValue: String, defaultValue: Double) -> String {
        print("changedValue: \(changedValue), defaultValue: \(defaultValue)")
        if (changedValue.trimmingCharacters(in: NSCharacterSet.whitespaces) == "") {
            return "\(String(format: "%.0f",defaultValue*100))%"
        } else {
            return "\(String(format: "%.0f",Double(changedValue) ?? 0))%"
        }
    }
    
}
