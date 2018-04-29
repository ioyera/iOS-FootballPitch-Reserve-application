//
//  EditProfile.swift
//  reserve.kz
//
//  Created by Yerassyl Duisenbi on 15.04.2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField
import FontAwesome_swift
import Alamofire
import SwiftyJSON

class EditProfile: UIViewController, UITextFieldDelegate {
    var post = AccountFetch()
    var name1 = SkyFloatingLabelTextFieldWithIcon()
//    frame: CGRect(x: 10, y: 100, width: 350, height: 45)
    var name2 = SkyFloatingLabelTextFieldWithIcon()
    var phone = SkyFloatingLabelTextFieldWithIcon()
    var password = SkyFloatingLabelTextFieldWithIcon()
    var confirm = SkyFloatingLabelTextFieldWithIcon()
    
    override func viewDidLoad() {
        AccountFetch.fetchProfile{ (mypost) in
            self.post = mypost
            self.name1.placeholder = mypost.name
            self.phone.placeholder = self.post.phone
            self.title = "Edit Profile"
            self.elements()
        }
        
        //        super.viewDidLoad()
    }
    func elements(){
        
        name1 = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Int(self.view.bounds.size.width*0.025), y: Int(self.view.bounds.size.height*0.13), width: Int(self.view.bounds.size.width*0.95), height: 50))
        name2 = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Int(self.view.bounds.size.width*0.025), y: Int(self.view.bounds.size.height*0.21), width: Int(self.view.bounds.size.width*0.95), height: 50))
        phone = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Int(self.view.bounds.size.width*0.025), y: Int(self.view.bounds.size.height*0.29), width: Int(self.view.bounds.size.width*0.95), height: 50))
        password = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Int(self.view.bounds.size.width*0.025), y: Int(self.view.bounds.size.height*0.37), width: Int(self.view.bounds.size.width*0.95), height: 50))
        confirm = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Int(self.view.bounds.size.width*0.025), y: Int(self.view.bounds.size.height*0.45), width: Int(self.view.bounds.size.width*0.95), height: 50))
        
        let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
        let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
        let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
        
        self.view.backgroundColor = UIColor.white
        name1.title = "Edit your name"
        name1.text = self.post.name
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
        
        name2.title = "Edit your surname"
        name2.text = self.post.surname

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
        
        phone.title = "Edit your mobile phone"
        phone.text = self.post.phone
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
        
        password.placeholder = "Old password"
        password.title = "Edit password"
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
        
        confirm.placeholder = "New password"
        confirm.title = "Edit your new password"
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
        
        let registerBtn = UIButton(frame: CGRect(x: Int(self.view.bounds.size.width*0.25), y: Int(self.view.bounds.size.height*0.6), width: Int(self.view.bounds.size.width*0.5), height: 50))
        registerBtn.layer.cornerRadius = 4
        registerBtn.setTitle("Edit", for: .normal)
        registerBtn.backgroundColor = overcastBlueColor
        registerBtn.addTarget(self, action: #selector(updateProfile), for: .touchUpInside)
        
        self.view.addSubview(name1)
        self.view.addSubview(name2)
        self.view.addSubview(phone)
        self.view.addSubview(password)
        self.view.addSubview(confirm)
        self.view.addSubview(registerBtn)
    }
    @objc func deleteProfile(){
        
        let optionMenu = UIAlertController(title: "После этого вы не сможете восстановить свои данные", message: "Вы уверены что хотите удалит свой аккаунт? ", preferredStyle: .actionSheet)
        
        
        let third = UIAlertAction(title: "Выйти", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            UserDefaults.standard.removeObject(forKey: "token")
            UserDefaults.standard.removeObject(forKey: "userId")

            let acc = LoginView()
            let url = "http://reservation.ga/api/client/delete/\(self.post.id)"
            
            Alamofire.request(url, method: .post).validate().responseJSON(completionHandler: {response in
                switch response.result {
                case .success:
                    print("Success")
                    if let value = response.result.value{
                        print("successfully loginned")
                        let json = JSON(value)
                        if json["status"].stringValue == "success"{
                            
                            
                            print(" name succesfully changed")
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
            
            self.addChildViewController(acc)
            self.view.addSubview(acc.view)
            acc.didMove(toParentViewController: self)
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        
        
        optionMenu.addAction(third)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
        
        
    }
    @objc func updateProfile(){
        
        
        
        print(post.name,"post name")
        print(name1.text!)
        if (name1.text!  != self.post.name  ){
            print("name changed")
            print(name1.text!,self.post.name)
            let url =  "http://reservation.ga/api/client/update/name/\(self.post.id)"
            print(url,"name not changed")
            let params = ["name": self.name1.text!]
            
        }else{
            print("name has not changed")
        }
//
        if name2.text!  != self.post.surname{
            print("surname has changed")
            print(self.post.surname,name2.text!)
            
            let url =  "http://reservation.ga/api/client/update/surname/\(self.post.id)"
            
            let params = ["surname": self.name2.text!]
            Alamofire.request(url, method: .post, parameters: params).validate().responseJSON(completionHandler: {response in
                switch response.result {
                case .success:
                    print("Success")
                    if let value = response.result.value{
                        print("successfully loginned")
                        let json = JSON(value)
                        if json["status"].stringValue == "success"{
                            
                            print("surname succesfully changed")
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
            print("surname not changed")
            print(self.post.surname,name2.text!)
            
           
        }




        if self.post.phone != phone.text!{
            print("phone  changed")
            print(self.post.phone ,phone.text!)
            let url =  "http://reservation.ga/api/client/update/phone/\(self.post.id)"
            print(url)
            let params = ["phone": self.phone.text!]
            print(params)
            Alamofire.request(url, method: .post, parameters: params).validate().responseJSON(completionHandler: {response in
                switch response.result {
                case .success:
                    print("Success")
                    if let value = response.result.value{
                        print("successfully loginned")
                        let json = JSON(value)
                        if json["status"].stringValue == "success"{
                            print(" phone successFully changed")
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
            print("phone  not changed")
            

            
        }

        if (password.text?.isEmpty == false) && (confirm.text?.isEmpty == false){
            print("password  changed")
            let url =  "http://reservation.ga/api/client/updatePassword/\(self.post.id)"
            
            let params = ["old_password": self.password.text! ,"new_password": self.confirm.text!]
            
            
            Alamofire.request(url, method: .post, parameters: params).validate().responseJSON(completionHandler: {response in
                switch response.result {
                case .success:
                    if let value = response.result.value{
                        let json = JSON(value)
                        if json["status"].stringValue == "success"{
                            print("password changed succesfully")
                            UserDefaults.standard.setValue(json["client"]["token"].stringValue, forKey: "token")
                        }else{
                            print("password not changed")
                        }
                    }
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            })
        }else{
            print("password not Changed")
           
        }
        


    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }

}
