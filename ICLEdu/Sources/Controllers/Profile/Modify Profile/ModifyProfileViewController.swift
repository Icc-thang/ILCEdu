//
//  ModifyProfileViewController.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/24.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import SDWebImage

class ModifyProfileViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    //full name
    @IBOutlet weak var fullNameTextField: UITextField!
    //home town
    @IBOutlet weak var addressTextField: UITextField!
    // male or female
    @IBOutlet weak var genderTextField: UITextField!
    //birthday
    @IBOutlet weak var dateOfBirthDay: UITextField!
    // phone number
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var datePicker : UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        dateOfBirthDay.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(dateChange(datePicker: )), for: .valueChanged)
    }
    
    @objc func dateChange(datePicker: UIDatePicker ) {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        dateOfBirthDay.text = dateFormat.string(from: datePicker.date)
    }
    
    func setupUI(){
        profilePicture.sd_setImage(with: URL(string: "https://i.pinimg.com/originals/b3/84/98/b38498a5830bd61ccef1b54d35a7de22.jpg" ))
        profilePicture.CircleImage()
        saveButton.BorderButton()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func saveProfile(_ sender: UIButton) {
        
        if fullNameTextField.text == "" {
            fullNameTextField.placeholder = "Điền thông tin còn trống!"
        }
        if addressTextField.text == "" {
            addressTextField.placeholder = "Điền thông tin còn trống!"
        }
        if genderTextField.text == "" {
            genderTextField.placeholder = "Điền thông tin còn trống!"
        }
        if dateOfBirthDay.text == "" {
            dateOfBirthDay.placeholder = "Điền thông tin còn trống!"
        }
        if phoneNumberTextField.text == "" {
            phoneNumberTextField.placeholder = "Điền thông tin còn trống!"
        }
        if fullNameTextField?.text != "" && addressTextField?.text != "" && genderTextField?.text != "" && dateOfBirthDay?.text != "" && phoneNumberTextField?.text != "" {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // Start Editing The Text Field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -150, up: true)
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -150, up: false)
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Move the text field in a pretty animation!
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
}
