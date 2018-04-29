//
//  BronsCell.swift
//  reserve.kz
//
//  Created by User on 19.02.18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import SnapKit

class BronsCell: UITableViewCell{
    let name = UILabel()
    let price = UILabel()
    let distance = UILabel()
    let golos = UILabel()
    let rating = UILabel()
    let number = UILabel()
    let logo = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        elements()
    }
    
    func elements(){
        addSubview(name)
        addSubview(price)
        addSubview(distance)
        addSubview(rating)
        addSubview(number)
        addSubview(logo)
        addSubview(golos)
        name.numberOfLines = 2
        name.snp.makeConstraints{
            (make) -> Void in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        logo.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(logo.snp.height)
        }
        
        
        
        rating.snp.makeConstraints{
            (make) -> Void in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        golos.snp.makeConstraints { (make) in
            make.left.equalTo(rating.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        
        price.textColor = Constants.background
        price.layer.cornerRadius = 10
        price.font = UIFont.init(name: "helvetica", size: 16)
        price.snp.makeConstraints{
            (make) -> Void in
            make.centerY.equalToSuperview()
            //make.left.equalTo(golos.snp.right).offset(5)
            make.right.equalToSuperview().offset(15)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalToSuperview().multipliedBy(0.85)
        }
        
        number.snp.makeConstraints{
            (make) -> Void in
            make.centerY.equalToSuperview()
            make.left.equalTo(logo.snp.right).offset(10)
            make.right.equalToSuperview().offset(10)
        }
    }
    

    
}




