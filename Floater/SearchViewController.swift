//
//  SearchViewController.swift
//  Floater
//
//  Created by Chris Dean on 2018-03-07.
//  Copyright © 2018 Chris Dean. All rights reserved.
//

import UIKit
import RealmSwift

//private extension Selector {
//    static let keyboardDidShow = #selector(SearchViewController.keyboardDidShow(notification:))
//}

class SearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var floaterRequest: UIButton!
    
    @IBOutlet weak var blogNameTextField: UITextField!
    @IBOutlet weak var floaterTypePicker: UIPickerView!
    
    var pickerData = [String]()
    var pickerChoice = String()
    
    var keyboardHeightFinal: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Connect data:
        self.floaterTypePicker.delegate = self
        self.floaterTypePicker.delegate = self
        
        // Input options into UIPickerView
        self.pickerData = ["", "animated", "static", "2D animated", "gif"]
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // UI for button
        floaterRequest.layer.cornerRadius = 5
        floaterRequest.layer.borderWidth = 1
        floaterRequest.layer.borderColor = UIColor.lightGray.cgColor
        floaterRequest.layer.shadowColor = UIColor.black.cgColor
        floaterRequest.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        floaterRequest.layer.shadowRadius = 5
        floaterRequest.layer.shadowOpacity = 1.0
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self, selector: #selector(SearchViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SearchViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        floaterTypePicker.selectRow(0, inComponent: 0, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let keyboardHeight = self.keyboardHeightFinal {
            UIView.animate(withDuration: 2, animations: {
                self.view.frame = self.view.frame.offsetBy(dx: 0, dy:(keyboardHeight/2))
            })
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            keyboardHeightFinal = keyboardHeight

            UIView.animate(withDuration: 2, animations: {
                self.view.frame = self.view.frame.offsetBy(dx: 0, dy:(-keyboardHeight/2))
            })
        }

    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
                
            UIView.animate(withDuration: 2, animations: {
                self.view.frame = self.view.frame.offsetBy(dx: 0, dy:(keyboardHeight/2))
            })
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        self.blogNameTextField.resignFirstResponder()
    }
    
//    (void)setupView {
//    // Animated background color
//    self.view.backgroundColor = [UIColor blueColor];
//    [UIView animateWithDuration:4 delay:0.0f options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{self.view.backgroundColor = [UIColor redColor];} completion:nil];
//
//    //    self.view.backgroundColor = [UIColor clearColor];
//
//    }
    
//    func setupView() {
//        self.view.backgroundColor = UIColor.blue
//        UIView.animate(withDuration: 4, delay: 0.0, options: repeat | autoreverse | beginFromCurrentState | allowUserInteraction | animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
//    }
//
    
   @objc @IBAction func makeApiCall(_ sender: Any) {
    
    self.floaterRequest.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
    
    UIView.animate(withDuration: 2.0,
                   delay: 0,
                   usingSpringWithDamping: CGFloat(0.20),
                   initialSpringVelocity: CGFloat(6.0),
                   options: UIViewAnimationOptions.allowUserInteraction,
                   animations: {
                    self.floaterRequest.transform = CGAffineTransform.identity
    },
                   completion: { Void in()  }
    )
        if blogNameTextField.text == "" {
            blogNameTextField.placeholder = "You entered nothing!!!"
        }
    }
    
    @objc override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "showCollection" {
      
            let controller = segue.destination as! CollectionViewController
            controller.blogName = blogNameTextField.text
            controller.floaterType = pickerChoice
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


