//
//  ModifyProfileViewController.swift
//  ICLEdu
//
//  Created by Duc Nguyen on 2019/9/24.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import SDWebImage

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
    
    @IBOutlet weak var segmentGender: UISegmentedControl!
    
    fileprivate let presenterRegister = PresenterRegister()
    
    fileprivate var numberContentSub:String?
    
    fileprivate var gender:String? = "Nữ"
    
    fileprivate var datePicker : UIDatePicker?
    
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
        profilePicture.sd_setImage(with: URL(string:avatar ?? avatarBase))
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

        let emailString = emailTextField.text ?? ""
//        if isValidEmail(emailStr: emailString) == true {
//            print("Email đúng định dạng")
//        }else {
//            self.noticeTop("メールの形式が正しくありません。")
//        }
        let nameString = fullNameTextField.text ?? ""
        let genderString = gender ?? ""
        let addressString = addressTextField.text ?? ""
        let dateString = dateOfBirthDay.text ?? ""
        let phoneString = phoneNumberTextField.text!.prefix(10)
        
        let param = ["name":nameString, "gender":genderString,"email":emailString,"address":addressString,"birthday":dateString,"phone": String(phoneString)]
        print(param)
        
        presenterRegister.getDataForRegister(
            nameString,
            genderString,
            emailString,
            addressString,
            dateString,
            String(phoneString))
//        if phoneString.count < 10 {
//            self.noticeTop("電話番号の形式が間違っています。")
//        }
//        if fullNameTextField.text == "" {
//            self.noticeTop("名前がありません。")
//        }
//        if  addressTextField.text == "" {
//            self.noticeTop("生年月日がありません。")
//        }
//        if dateOfBirthDay.text == "" {
//            self.noticeTop("生年月日がありません。")
//        }
//        if phoneNumberTextField.text == "" {
//            self.noticeTop("電話番号がありません。")
//        }
//        if emailTextField.text == "" {
//            self.noticeTop("メールがありません。")
//        }
        
//        let slice = phoneString.prefix(2)
//        if slice == "09" || slice == "08" || slice == "07" || slice == "05" || slice == "03" {
//            print("ngon")
//        }else {
//            self.noticeTop("電話番号の形式が間違っています。")
//        }
        

    }
    
//     func isValidEmail(emailStr:String) -> Bool {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//
//        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailPred.evaluate(with: emailStr)
//    }
//
    @IBAction func phoneNumberChange(_ sender: UITextField) {
//        maxLength(textField: phoneNumberTextField, max: 10)
    }
    
}

extension RegisterViewController: DelegateRegister{
    func getDataRegister() {
        if presenterRegister.registerModel?.access_token == "" || presenterRegister.registerModel?.access_token == nil {
            print("tạch")
        }else {
            UserDefaults.standard.set(self.presenterRegister.registerModel?.access_token ?? "", forKey: "authorization")
            let tabbarVC = UIStoryboard(name: tabbarController, bundle: nil).instantiateViewController(withIdentifier: tabbarController) as! BubbleTabBarController
            self.navigationController?.pushViewController(tabbarVC, animated: true)
        }
    }
}

extension RegisterViewController: UITextFieldDelegate{
//    func maxLength(textField: UITextField, max: Int){
//        let length = textField.text?.count
//        let content = textField.text
//        if length! > max{
//            let index = content?.index(content!.startIndex, offsetBy: max)
//            textField.text = textField.text?.substring(to: index!)
//        }
//    }
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
