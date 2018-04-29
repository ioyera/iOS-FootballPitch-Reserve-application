//
//  Registration.swift
//  reserve.kz
//knalDSguefw
//  Created by User on 28.03.18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField
import FontAwesome_swift
import Alamofire
import SwiftyJSON
class Registration: UIViewController, UITextFieldDelegate{
    
    let name1 = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: 10, y: 100, width: 350, height: 45))
    let name2 = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: 10, y: 160, width: 350, height: 45))
    let email = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: 10, y: 220, width: 350, height: 45))
    let phone = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: 10, y: 280, width: 350, height: 45))
    let password = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: 10, y: 340, width: 350, height: 45))
    let confirm = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: 10, y: 400, width: 350, height: 45))

    override func viewDidLoad() {
        elements()
        
        navigationController?.navigationBar.barTintColor = Constants.background
        navigationController?.title = "Sign Up"
        
        self.modalPresentationStyle = .popover

    }
    func elements(){
        let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
        let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
        let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
        
        self.view.backgroundColor = UIColor.white
        name1.placeholder = "First Name"
        name1.title = "Your first name"
        name1.tintColor = overcastBlueColor // the color of the blinking cursor
        name1.textColor = darkGreyColor
        name1.lineColor = lightGreyColor
        name1.selectedTitleColor = overcastBlueColor
        name1.selectedLineColor = overcastBlueColor
        name1.lineHeight = 1.0 // bottom line height in points
        name1.selectedLineHeight = 2.0
        name1.iconType = .font
        name1.iconColor = UIColor.lightGray
        name1.selectedIconColor = overcastBlueColor
        name1.iconFont = UIFont.fontAwesome(ofSize: 15)
        name1.iconText =  String.fontAwesomeIcon(name: .user)
        name1.iconMarginBottom = 4.0 // more precise icon positioning. Usually needed to tweak on a per font basis.
        name1.iconRotationDegrees = 0 // rotate it 90 degrees
        name1.iconMarginLeft = 2.0
        
        name2.placeholder = "Second name"
        name2.title = "Your second name"
        
        name2.tintColor = overcastBlueColor // the color of the blinking cursor
        name2.textColor = darkGreyColor
        name2.lineColor = lightGreyColor
        name2.selectedTitleColor = overcastBlueColor
        name2.selectedLineColor = overcastBlueColor
        name2.lineHeight = 1.0 // bottom line height in points
        name2.selectedLineHeight = 2.0
        name2.iconType = .font
        name2.iconColor = UIColor.lightGray
        name2.selectedIconColor = overcastBlueColor
        name2.iconFont = UIFont.fontAwesome(ofSize: 15)
        name2.iconText =  String.fontAwesomeIcon(name: .users)
        name2.iconMarginBottom = 4.0 // more precise icon positioning. Usually needed to tweak on a per font basis.
        name2.iconRotationDegrees = 0 // rotate it 90 degrees
        name2.iconMarginLeft = 2.0
        
        email.placeholder = "Email"
        email.title = "Your email"
        email.tintColor = overcastBlueColor // the color of the blinking cursor
        email.textColor = darkGreyColor
        email.lineColor = lightGreyColor
        email.selectedTitleColor = overcastBlueColor
        email.selectedLineColor = overcastBlueColor
        email.lineHeight = 1.0 // bottom line height in points
        email.selectedLineHeight = 2.0
        // Set icon properties
        email.iconType = .font
        email.iconColor = UIColor.lightGray
        email.selectedIconColor = overcastBlueColor
        email.iconFont = UIFont.fontAwesome(ofSize: 15)
        email.iconText =  String.fontAwesomeIcon(name: .envelope)
        email.iconMarginBottom = 4.0 // more precise icon positioning. Usually needed to tweak on a per font basis.
        email.iconRotationDegrees = 0 // rotate it 90 degrees
        email.iconMarginLeft = 2.0
        email.errorColor = UIColor.red
        //        email.delegate = self
        //        email.isEnabled = true
        //        email.errorMessage = "Invalid Email"
        
        phone.placeholder = "Phone number"
        phone.title = "Your phone number"
        phone.tintColor = overcastBlueColor // the color of the blinking cursor
        phone.textColor = darkGreyColor
        phone.lineColor = lightGreyColor
        phone.selectedTitleColor = overcastBlueColor
        phone.selectedLineColor = overcastBlueColor
        phone.lineHeight = 1.0 // bottom line height in points
        phone.selectedLineHeight = 2.0
        
        phone.iconType = .font
        phone.iconColor = UIColor.lightGray
        phone.selectedIconColor = overcastBlueColor
        phone.iconFont = UIFont.fontAwesome(ofSize: 15)
        phone.iconText =  String.fontAwesomeIcon(name: .phone)
        phone.iconMarginBottom = 4.0 // more precise icon positioning. Usually needed to tweak on a per font basis.
        phone.iconRotationDegrees = 90 // rotate it 90 degrees
        phone.iconMarginLeft = 2.0
        phone.delegate = self
        
        password.placeholder = "Password"
        password.title = "Your password"
        password.tintColor = overcastBlueColor // the color of the blinking cursor
        password.textColor = darkGreyColor
        password.lineColor = lightGreyColor
        password.selectedTitleColor = overcastBlueColor
        password.selectedLineColor = overcastBlueColor
        password.lineHeight = 1.0 // bottom line height in points
        password.selectedLineHeight = 2.0
        password.isSecureTextEntry = true
        password.iconType = .font
        password.iconColor = UIColor.lightGray
        password.selectedIconColor = overcastBlueColor
        password.iconFont = UIFont.fontAwesome(ofSize: 15)
        password.iconText =  String.fontAwesomeIcon(name: .lock)
        password.iconMarginBottom = 4.0 // more precise icon positioning. Usually needed to tweak on a per font basis.
        password.iconRotationDegrees = 0 // rotate it 90 degrees
        password.iconMarginLeft = 2.0
        
        confirm.placeholder = "Confirm password"
        confirm.title = "Confirm your password"
        confirm.tintColor = overcastBlueColor // the color of the blinking cursor
        confirm.textColor = darkGreyColor
        confirm.lineColor = lightGreyColor
        confirm.selectedTitleColor = overcastBlueColor
        confirm.selectedLineColor = overcastBlueColor
        confirm.lineHeight = 1.0 // bottom line height in points
        confirm.selectedLineHeight = 2.0
        confirm.isSecureTextEntry = true
        confirm.iconType = .font
        confirm.iconColor = UIColor.lightGray
        confirm.selectedIconColor = overcastBlueColor
        confirm.iconFont = UIFont.fontAwesome(ofSize: 15)
        confirm.iconText =  String.fontAwesomeIcon(name: .lock)
        confirm.iconMarginBottom = 4.0 // more precise icon positioning. Usually needed to tweak on a per font basis.
        confirm.iconRotationDegrees = 0 // rotate it 90 degrees
        confirm.iconMarginLeft = 2.0
        
        let registerBtn = UIButton(frame: CGRect(x: Int(self.view.bounds.size.width*0.25), y: 500, width: Int(self.view.bounds.size.width*0.5), height: 50))
        registerBtn.layer.cornerRadius = 4
        registerBtn.setTitle("Register", for: .normal)
        registerBtn.backgroundColor = overcastBlueColor
        registerBtn.addTarget(self, action: #selector(registerProfile), for: .touchUpInside)
        
        self.view.addSubview(name1)
        self.view.addSubview(name2)
        self.view.addSubview(email)
        self.view.addSubview(phone)
        self.view.addSubview(password)
        self.view.addSubview(confirm)
        self.view.addSubview(registerBtn)
    }
    @objc func registerProfile(){
        
        
        let url =  "http://reservation.ga/api/client/register"
        
        let params = ["name": name1.text!, "surname": name2.text!, "phone": phone.text!, "email": email.text!,"password": password.text! ]
        print(params)
        
        if (name1.text != "" && name2.text != "" && name2.text != "" && phone.text != "" && email.text != "" && password.text != ""){
            Alamofire.request(url, method: .post, parameters: params).validate().responseJSON(completionHandler: {response in
                switch response.result {
                case .success:
                    print("Success")
                    if let value = response.result.value{
                        print("successfully loginned")
                        let json = JSON(value)
                        if json["status"].stringValue == "success"{
                            
                            let token : String = json["client"]["token"].stringValue
                            let userId : String = json["client"]["id"].stringValue

                            let acc = AccountView()
                            UserDefaults.standard.setValue(token, forKey: "token")
                            UserDefaults.standard.setValue(userId, forKey: "userId")
                            AccountFetch.fetchProfile{ (post) in
                                acc.post = post
                                self.addChildViewController(acc)
                                self.view.addSubview(acc.view)
                                acc.didMove(toParentViewController: self)
                                
                            }
                        }else{
                            print("error")
                        }
                    }
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            })
            
        }else{
            print("some statement is nil")
        }
    }
//    func textField(email: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        if let text = email.text {
//            if let floatingLabelTextField = email as? SkyFloatingLabelTextField {
//                if(text.characters.count < 3 || !text.contains("@")) {
//                    floatingLabelTextField.errorMessage = "Invalid email"
//                }
//                else {
//                    // The error message will only disappear when we reset it to nil or empty string
//                    floatingLabelTextField.errorMessage = ""
//                }
//            }
//        }
//        return true
//    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
