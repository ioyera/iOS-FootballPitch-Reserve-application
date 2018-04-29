//
//  Constants.swift
//  reserve.kz
//
//  Created by User on 05.02.18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
struct Constants{
    static let background: UIColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    static let cell : UIColor = UIColor(red: 250/255, green: 246/255, blue: 230/255, alpha: 1)
    static let footer: UIColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
}
struct Reserve{
    let logo : UIImage
    let name : String
    let price : Int
    let distance : Int
    let rating : Double
}
extension UIViewController{
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc  func dismissKeyboard() {
        view.endEditing(true)
    }
}

class CustomSearchTextField: UITextField {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,
                                     UIEdgeInsetsMake(0, 15, 0, 15))
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,
                                     UIEdgeInsetsMake(0, 15, 0, 15))
    }
}
