//
//  LoginView.swift
//  reserve.kz
//
//  Created by User on 09.04.18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON
import SkyFloatingLabelTextField

class LoginView: UIViewController {
//    let myview = UIView()
//    let login = UITextField()
//    let password = UITextField()
//    let signIn = UIButton()

    var register = UIButton()
    var label = UILabel()
    
    var login = SkyFloatingLabelTextFieldWithIcon()
    var password = SkyFloatingLabelTextFieldWithIcon()
    var signIn = UIButton()
    
    let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
    let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elements()
        
        navigationController?.navigationBar.barTintColor = Constants.background
        navigationController?.title = "Login"
        hideKeyboardWhenTappedAround()
        self.view.backgroundColor = UIColor.white
        
    }
    func elements(){
        login = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Int(self.view.bounds.size.width*0.125), y: Int(self.view.bounds.size.height*0.33), width: Int(self.view.bounds.size.width*0.75), height: 50))
        login.placeholder = "Username"
        login.title = "Your username"
        login.tintColor = overcastBlueColor // the color of the blinking cursor
        login.textColor = darkGreyColor
        login.lineColor = lightGreyColor
        login.selectedTitleColor = overcastBlueColor
        login.selectedLineColor = overcastBlueColor
        login.lineHeight = 1.0 // bottom line height in points
        login.selectedLineHeight = 2.0
        login.iconType = .font
        login.iconColor = UIColor.lightGray
        login.selectedIconColor = overcastBlueColor
        login.iconFont = UIFont.fontAwesome(ofSize: 15)
        login.iconText =  String.fontAwesomeIcon(name: .user)
        login.iconMarginBottom = 4.0 // more precise icon positioning. Usually needed to tweak on a per font basis.
        login.iconRotationDegrees = 0 // rotate it 90 degrees
        login.iconMarginLeft = 2.0
//        login.snp.makeConstraints { (make) in
//
        
        
        password = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Int(self.view.bounds.size.width*0.125), y: Int(self.view.bounds.size.height*0.42), width: Int(self.view.bounds.size.width*0.75), height: 50))
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
        
        
        signIn = UIButton(frame: CGRect(x: Int(self.view.bounds.size.width*0.2), y: Int(self.view.bounds.size.height*0.53), width: Int(self.view.bounds.size.width*0.6), height: Int(self.view.bounds.size.width*0.13)))
        signIn.layer.cornerRadius = 10
        signIn.setTitle("Log in", for: .normal)
        signIn.backgroundColor = overcastBlueColor

        
        self.view.addSubview(password)
        self.view.addSubview(signIn)
        self.view.addSubview(register)
        self.view.addSubview(label)
        self.view.addSubview(login)
        self.view.backgroundColor = UIColor.white
        
        signIn.addTarget(self, action: #selector(loginning), for: .touchUpInside)
        
        register.setTitle("Зарегестрироваться", for: .normal)
        register.titleLabel!.font = UIFont(name: "helvetica", size: 14)
        register.addTarget(self, action: #selector(registration), for: .touchUpInside)
        register.setTitleColor(UIColor.blue, for: .normal)
        register.snp.makeConstraints{
            (make) -> Void in
            
        make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-200)
            make.right.equalTo(signIn.snp.right).offset(0)
            
        }
        label.text = "Нет аккаунта?"
        label.font = UIFont(name: "helvetica",size: 13)
        label.textColor = UIColor.darkGray
        label.snp.makeConstraints { (make) in
            make.centerY.equalTo(register.snp.centerY)
            make.right.equalTo(register.snp.left).offset(-4)
        }
        

        
    }
    @objc func registration(){
        //navigationController?.pushViewController(Registration(), animated: true)
        let regist = Registration()
        regist.modalPresentationStyle = .popover

        self.present(regist, animated: true, completion: nil)
    }
    
    @objc func loginning(){
        let url = "http://reservation.ga/api/client/login"
        let params = ["email":self.login.text! ,"password": self.password.text!]
        
        Alamofire.request(url, method: .post, parameters: params).validate().responseJSON(completionHandler: {response in
            switch response.result{
            case .success:
                if let value = response.result.value{
                    print("successfully loginned")
                    let json = JSON(value)
                    if json["status"].stringValue == "success"{
                        
                        let token : String = json["client"]["token"].stringValue
                        let userId: String = json["client"]["id"].stringValue
                        let acc = AccountView()
                        UserDefaults.standard.setValue(token, forKey: "token")
                        UserDefaults.standard.setValue(userId, forKey: "userId")
                        AccountFetch.fetchProfile{ (post) in
                            acc.post = post
//                            self.addChildViewController(acc)
//                            self.view.addSubview(acc.view)
//                            acc.didMove(toParentViewController: self)
                            self.present(AccountView(), animated: true, completion: nil)

                        }
                    }else{
                        print("error")
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
