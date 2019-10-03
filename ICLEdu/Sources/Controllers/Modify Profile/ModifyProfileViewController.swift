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
import FBSDKLoginKit

class ModifyProfileViewController: UIViewController {
    
    @IBOutlet var btnFacebook: UIButton!
    
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
    
    @IBOutlet weak var profileView: UIView!
    
    var datePicker : UIDatePicker?
    
    private let presenterMP = PresenterModifyProfile()
    
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
        presenterMP.delegateModify = self as? DelegateModifyProfile
        btnFacebook.BorderButton()
    }
    
    @objc func dateChange(datePicker: UIDatePicker ) {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        dateOfBirthDay.text = dateFormat.string(from: datePicker.date)
    }
    
    @IBAction func loginWithFacebook(_ sender: Any) {
        let manager = LoginManager()
        manager.logIn(permissions: [ .publicProfile, .email], viewController: self) { (result) in
            switch result {
            case .success(let granted, let declined, let token):
                print("token is : \(token)")
                let param = ["fields": "email, name, picture.type(large)"]
                GraphRequest(graphPath: "me", parameters: param).start { (connection, result, error) in
                    if let result = result {
                        let dict = JSON(result)
                        let email = dict["email"].stringValue
                        let name = dict["name"].stringValue
                        let avatar = dict["picture"]["data"]["url"].stringValue
                        let fb_id = dict["id"].stringValue
                        print(dict)

                        
                        self.presenterMP.getProfileFBData(avatar: avatar , name: name)
                        self.profileView.isHidden = false
                        self.saveButton.isHidden = false
                        self.setupUI()
                    }
                }
            case .cancelled:
                print("Cancelled")
                break
            case .failed(let err):
                print("login failed, error:\(err)")
                break
            }
        }
        
    }
    
    func setupUI(){
        profilePicture.sd_setImage(with: URL(string:"\(presenterMP.avatarURL ?? "Không có dữ liệu cho ảnh")"))
        profilePicture.CircleImage()
        
        saveButton.BorderButton()
        
        fullNameTextField.text = presenterMP.fullName
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // date picker for birthday
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        dateOfBirthDay.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(dateChange(datePicker: )), for: .valueChanged)
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
            
            UserDefaults.standard.set(true, forKey: "status")
            
            //push to lesson view controller
            let storyboard = UIStoryboard(name: "LessonController", bundle: Bundle.main)
            let lessonVC = storyboard.instantiateViewController(withIdentifier: "LessonController") as! LessonViewController
            if let navigator = navigationController {
                navigator.pushViewController(lessonVC, animated: true)
            }
        }
    }
}

extension ModifyProfileViewController: UITextFieldDelegate{
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
