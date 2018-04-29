//
//  MainCell.swift
//  reserve.kz
//
//  Created by User on 05.02.18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import SnapKit

class MainCell: UITableViewCell {
    var logo = UIImageView()
    let name = UILabel()
    let distance = UILabel()
    let price = UILabel()
    let rating = UILabel()
    let favor = UIButton()
    let address = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        elements()
        
    }
    
    
    func elements(){
        addSubview(address)
        addSubview(logo)
        addSubview(name)
        addSubview(distance)
        addSubview(price)
        addSubview(rating)
        addSubview(favor)
        
        logo.snp.makeConstraints{
            (make) -> Void in
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalTo(logo.snp.height)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        favor.snp.makeConstraints { (make) in
            make.top.equalTo(logo.snp.top).offset(0)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(30)
            make.width.equalTo(30)
            
        }
        
        name.numberOfLines = 2
        name.textColor = UIColor.black
        name.font = UIFont.boldSystemFont(ofSize: 15)
        name.snp.makeConstraints{
            (make) -> Void in
            
            make.top.equalTo(logo.snp.top).offset(0)
            make.left.equalTo(logo.snp.right).offset(5)
            make.right.equalTo(favor.snp.left).offset(5)
        }
        address.numberOfLines = 3
        address.textColor = UIColor.gray
        address.font = UIFont.boldSystemFont(ofSize: 13)
        address.snp.makeConstraints{
            (make) -> Void in
            make.centerY.equalTo(logo.snp.centerY)
            make.left.equalTo(logo.snp.right).offset(5)
            make.right.equalToSuperview().offset(-5)
        }
        
        
        rating.textColor = UIColor.red
        rating.font = UIFont.boldSystemFont(ofSize: 14)
        rating.snp.makeConstraints{
            (make) -> Void in
            make.left.equalTo(logo.snp.right).offset(10)
            make.top.equalTo(address.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-10)
            
        }
        
       
        
        
        
        print(price.frame.height,"height")
        price.textColor = Constants.background
        price.layer.borderWidth = 2
        price.layer.borderColor = Constants.background.cgColor
        price.layer.cornerRadius = 10
        price.font = UIFont.init(name: "helvetica", size: 14)
        price.snp.makeConstraints{
            (make) -> Void in
            make.bottom.equalTo(logo.snp.bottom)
            make.right.equalToSuperview().offset(20)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(rating.snp.height).multipliedBy(1.5)
        }

        
        
        
        
    }
}
