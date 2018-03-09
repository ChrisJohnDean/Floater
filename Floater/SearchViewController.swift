//
//  SearchViewController.swift
//  Floater
//
//  Created by Chris Dean on 2018-03-07.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var floaterRequest: UIButton!
    
    let networkManager = NetworkManager()
    
    @IBOutlet weak var blogNameTextField: UITextField!
    @IBOutlet weak var floaterTypePicker: UIPickerView!
    
    
    var pickerData = [String]()
    
    var pickerChoice = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Connect data:
        self.floaterTypePicker.delegate = self
        self.floaterTypePicker.delegate = self
        
        // Input options into UIPickerView
        self.pickerData = ["animated", "static", "2D animated", "gif"]
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // UI for button
        floaterRequest.layer.cornerRadius = 5
        floaterRequest.layer.borderWidth = 1
        floaterRequest.layer.borderColor = UIColor.black.cgColor
        floaterRequest.layer.shadowColor = UIColor.black.cgColor
        floaterRequest.layer.shadowOffset = CGSize(width: 5, height: 5)
        floaterRequest.layer.shadowRadius = 5
        floaterRequest.layer.shadowOpacity = 1.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
   @objc @IBAction func makeApiCall(_ sender: Any) {
    
        if blogNameTextField.text == "" {
            blogNameTextField.placeholder = "You entered nothing!!!"
        } else {
            networkManager.tumblrNetworkRequest(blogNameTextField.text, withFloaterType: pickerChoice)
        }
    }
    

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickerChoice = pickerData[row];
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
