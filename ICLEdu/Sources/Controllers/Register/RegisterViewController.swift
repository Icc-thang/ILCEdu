//
//  ModifyProfileViewController.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/24.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import SDWebImage
import FacebookCore
import FacebookLogin
import SwiftyJSON

class RegisterViewController: UIViewController, UIActionSheetDelegate {
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var saveButton: UIButton!
    //full name
    @IBOutlet weak var fullNameTextField: UITextField!
    //home town
    @IBOutlet weak var addressTextField: UITextField!
    //birthday
    @IBOutlet weak var dateOfBirthDay: UITextField!
    // phone number
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var dotComTextField: UITextField!
    
    var gender:String? = "Nữ"
    
    var datePicker : UIDatePicker?
    
    @IBOutlet weak var segmentGender: UISegmentedControl!
    
    private let presenterRegister = PresenterRegister()
    
    var numberContentSub:String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenterRegister.delegateRegister = self
        setupUI()
    }
    
    func setupUI(){
        profilePicture.sd_setImage(with: URL(string:avatar!))
        profilePicture.CircleImage()
        
        saveButton.LoginButton()
        
        fullNameTextField.text = name
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // date picker for birthday
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
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func selectGender(_ sender: Any) {
        switch segmentGender.selectedSegmentIndex {
        case 0:
            gender = "Nữ"
        case 1:
            gender = "Nam"
        default:
            break
        }
    }
    
    @IBAction func saveProfile(_ sender: UIButton) {
        
        if fullNameTextField.text == "" {
            fullNameTextField.placeholder = "Nhập họ và tên!"
        }
        if addressTextField.text == "" {
            addressTextField.placeholder = "Nhập địa chỉ!"
        }
        if dateOfBirthDay.text == "" {
            dateOfBirthDay.placeholder = "Nhập ngày sinh!"
        }
        if phoneNumberTextField.text == "" {
            phoneNumberTextField.placeholder = "Nhập số điện thoại!"
        }
        if emailTextField.text == "" {
            emailTextField.placeholder = "Nhập email!"
        }
        
        if dotComTextField.text == "" {
            dotComTextField.placeholder = "***.com"
        }
        
        let string = phoneNumberTextField.text!.prefix(10)
        let slice = string.prefix(2)
        
        if string.count < 10 {
            phoneNumberTextField.text = ""
            phoneNumberTextField.placeholder = "số điện thoại không hợp lệ"}
        
        if fullNameTextField?.text != "" && slice == "09" || slice == "08" || slice == "07" || slice == "05" || slice == "03" && addressTextField?.text != "" && dateOfBirthDay?.text != "" && emailTextField.text != "" {
            
            //
            print("email : \(emailTextField.text ?? "")@\(dotComTextField.text ?? "")")
            print("name: \(fullNameTextField.text!)")
            print("gender: \(gender ?? "")")
            print("address: \(addressTextField.text!)")
            print("birth day: \(dateOfBirthDay.text!)")
            print("phone number: \(phoneNumberTextField!.text!)")
            print("memberID: \(member_id)")
            
            presenterRegister.getDataForRegister(
                member_name: fullNameTextField.text!,
                member_gender: gender ?? "",
                member_email: "\(emailTextField.text ?? "")@\(dotComTextField.text ?? "")",
                member_address: addressTextField?.text ?? "",
                member_birthday: dateOfBirthDay.text ?? "",
                member_phone: phoneNumberTextField?.text ?? "0")
        }
    }
    
    @IBAction func phoneNumberChange(_ sender: UITextField) {
        maxLength(textField: phoneNumberTextField, max: 10)
    }
    
}

extension RegisterViewController: DelegateRegister{
    func getDataRegister() {
        if(tokenDatabase != nil || tokenDatabase != ""){
            UserDefaults.standard.set(self.presenterRegister.registerModel?.access_token ?? "", forKey: "authorization")
            let tabbarVC = UIStoryboard(name: "TabbarController", bundle: nil).instantiateViewController(withIdentifier: "TabbarController") as! BubbleTabBarController
            self.navigationController?.pushViewController(tabbarVC, animated: true)
        }
    }
}

extension RegisterViewController: UITextFieldDelegate{
    func maxLength(textField: UITextField, max: Int){
        let length = textField.text?.count
        let content = textField.text
        if length! > max{
            let index = content?.index(content!.startIndex, offsetBy: max)
            textField.text = textField.text?.substring(to: index!)
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
