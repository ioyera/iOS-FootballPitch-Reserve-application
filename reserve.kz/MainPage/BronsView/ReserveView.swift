//
//  ReserveView.swift
//  reserve.kz
//
//  Created by Yerassyl Duisenbi on 14.04.2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import SnapKit
import QuartzCore
import Alamofire
import SwiftyJSON

class ReserveView: UIViewController {
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let startBlur: UIColor = UIColor(red:0.20, green:0.76, blue:0.85, alpha:1.0)
    let endBlur: UIColor = UIColor(red:0.31, green:0.31, blue:0.61, alpha:1.0)
    
    let text: UILabel = UILabel()
    let schedulebtn: UIButton = UIButton()
    let dateLabel: UILabel = UILabel()
    let startTime1: UITextField = UITextField()
    let startTime2: UITextField = UITextField()
    let endTime1: UITextField = UITextField()
    let endTime2: UITextField = UITextField()
    let between: UILabel = UILabel()
    let pickData =  UIButton()
    let icon = UIImageView()
    let bronBut = UIButton()
    
    var today_string =  String()

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    @objc func scheduleView(){
        navigationController?.pushViewController(ScheduleView(), animated: true)
//        navigationController?.popViewController(animated: true)
    }
    
    @objc func showCalendar(){
        
        let calendar = CalenderView()
        calendar.myProtocol = ViewController()
        
        navigationController?.pushViewController(ViewController(), animated: true)
    }
    func setupViews(){
        
        view.addSubview(text)
        view.addSubview(schedulebtn)
        view.addSubview(dateLabel)
        view.addSubview(startTime1)
        view.addSubview(startTime2)
        view.addSubview(endTime1)
        view.addSubview(endTime2)
        view.addSubview(between)
        view.addSubview(pickData)
        view.addSubview(bronBut)
        
//        self.view.setGradientColor(colorOne: endBlur, colorTwo: startBlur)
        self.view.backgroundColor = UIColor.white
        text.text = "Choose your date, time and book it"
        text.isEnabled = true
        text.textAlignment = .center
        text.font = UIFont(name: "AmericanTypewriter-CondensedBold", size:20)
        
        
        

        schedulebtn.center = self.view.center
        schedulebtn.setTitle("Show Srchedule", for: UIControlState.normal)
        schedulebtn.backgroundColor = Constants.background
        schedulebtn.titleLabel?.font = UIFont(name: "AmericanTypewriter-CondensedBold", size: 25)
        schedulebtn.layer.cornerRadius = 15
        schedulebtn.addTarget(self, action: #selector(self.scheduleView), for: .touchUpInside)
        
        dateLabel.text = "Сегодня:"
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont(name: "helvetica", size:16)
        dateLabel.textColor = UIColor.gray
        
        startTime1.keyboardType = .numberPad
        startTime1.placeholder = "hh"
        startTime1.textAlignment = .center
        startTime1.font = UIFont(name: "Simple", size:25)
        startTime1.layer.masksToBounds = true
        startTime1.layer.borderColor = UIColor.gray.cgColor
        startTime1.layer.borderWidth = 1.5
        
        
        
        
        startTime2.isEnabled = false
        startTime2.text = "00"
        startTime2.textAlignment = .center
        startTime2.font = UIFont(name: "Simple", size:25)
        startTime2.layer.masksToBounds = true
        startTime2.layer.borderColor = UIColor.gray.cgColor
        startTime2.layer.borderWidth = 1.5
        
        endTime1.placeholder = "hh"
        endTime1.textAlignment = .center
        endTime1.font = UIFont(name: "Simple", size:25)
        endTime1.layer.masksToBounds = true
        endTime1.layer.borderColor = UIColor.gray.cgColor
        endTime1.layer.borderWidth = 1.5
        
        endTime2.isEnabled = false
        endTime2.text = "00"
        endTime2.textAlignment = .center
        endTime2.font = UIFont(name: "Simple", size:25)
        endTime2.layer.masksToBounds = true
        endTime2.layer.borderColor = UIColor.gray.cgColor
        endTime2.layer.borderWidth = 1.5
        
        between.text = "-"
        between.isEnabled = true
        between.textAlignment = .center
        between.font = UIFont(name: "AmericanTypewriter-CondensedBold", size:25)
        
        
        text.backgroundColor = UIColor.white
        
        text.snp.makeConstraints{
            (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(5)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.centerX.equalToSuperview()
        }
        
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(text.snp.bottom).offset(10)
            make.width.equalToSuperview()
        }
        
        let date = Date()
        let calender = Calendar.current
        
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let day = components.day
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let month = dateFormatter.string(from: now)
        let year = components.year
        self.today_string = String(day!) + "-" + month + "-" + String(year!)
        
        
        
        
        pickData.setTitle(today_string, for: UIControlState.normal)
        pickData.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        pickData.setTitleColor(Constants.background, for: .normal)
        pickData.addTarget(self, action: #selector(showCalendar), for: .touchUpInside)
        pickData.layer.cornerRadius = 15
        pickData.layer.borderWidth = 2
        pickData.layer.borderColor  = Constants.background.cgColor
        pickData.addSubview(icon)
        
        //icon.image = UIImage(named: "logo")
        
        icon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.height.equalToSuperview().multipliedBy(0.6)
            make.width.equalTo(icon.snp.height)
        }
        
        pickData.snp.makeConstraints{
            (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.width.equalTo(schedulebtn.snp.width)
            make.height.equalTo(schedulebtn.snp.height)
            make.centerX.equalToSuperview()
        }
        
        schedulebtn.snp.makeConstraints { (make) in
            make.top.equalTo(startTime2.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(50)
        }
        
        
        bronBut.setTitle("Бронировать", for: .normal)
        bronBut.backgroundColor = Constants.background
        bronBut.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        bronBut.addTarget(self, action: #selector(bronirovat), for: .touchUpInside)
        bronBut.snp.makeConstraints { (make) in
            make.top.equalTo(schedulebtn.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.05)
            make.width.equalTo(schedulebtn.snp.width)
        }
        
        startTime1.snp.makeConstraints { (make) in
            make.top.equalTo(pickData.snp.bottom).offset(15)
            make.width.equalTo(50)
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(30)
        }
        startTime2.snp.makeConstraints { (make) in
            make.top.equalTo(pickData.snp.bottom).offset(15)
            make.width.equalTo(50)
            make.height.equalTo(30)
            make.left.equalTo(startTime1.snp.right).offset(30)
        }
        endTime1.snp.makeConstraints { (make) in
            make.top.equalTo(pickData.snp.bottom).offset(15)
            make.right.equalTo(endTime2.snp.left).offset(-30)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        endTime2.snp.makeConstraints { (make) in
            make.top.equalTo(pickData.snp.bottom).offset(15)
            make.right.equalToSuperview().offset(-30)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        between.snp.makeConstraints { (make) in
            make.top.equalTo(pickData.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(endTime1.snp.height)
        }
        
    }
    @objc func bronirovat(){
        
        let clientId = UserDefaults.standard.value(forKey: "userId")!
        let pitchId = UserDefaults.standard.value(forKey: "id")!
        let date = self.pickData.titleLabel!
        let fromTime = self.startTime1.text! + ":" + self.startTime2.text!
        let toTime = self.endTime1.text! + ":" + self.endTime2.text!
        let url = "http://reservation.ga/api/booking/add"
        let params = ["client_id": clientId , "pitch_id": pitchId ,"date": date.text,"from_time": fromTime,"to_time" : toTime]
        print(params)
        
        Alamofire.request(url, method: .post, parameters: params).validate().responseJSON(completionHandler: {response in
            switch response.result{
            case .success:
                if let value = response.result.value{
                    let json = JSON(value)
                    if json["status"].stringValue == "success"{
                        print("successfully bronned")
                        
                        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
                        self.navigationController!.popToViewController(viewControllers[2], animated: true);
                        
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
extension UIView{
    
    
    func setGradientColor(colorOne: UIColor, colorTwo: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0,y: 0.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }

}
