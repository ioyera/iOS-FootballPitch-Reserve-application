//
//  AccountView.swift
//  reserve.kz
//
//  Created by User on 03.04.18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import Lottie
import GearRefreshControl

class AccountView: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var tableView = UITableView()
    
    var post = AccountFetch()
    var gearRefreshControl: GearRefreshControl!
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        gearRefreshControl.scrollViewDidScroll(scrollView)
    }
    @objc func refresh(){
        let popTime = DispatchTime.now() + Double(Int64(3.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC);
        DispatchQueue.main.asyncAfter(deadline: popTime) { () -> Void in
            self.gearRefreshControl.endRefreshing()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        gearRefreshControl = GearRefreshControl(frame: self.view.bounds)
        gearRefreshControl.addTarget(self, action: #selector(MainView.refresh), for: UIControlEvents.valueChanged)
        gearRefreshControl.gearTintColor = Constants.background
        tableView.refreshControl = gearRefreshControl
        self.title = "Account"
        self.modalPresentationStyle = .overCurrentContext
        AccountFetch.fetchProfile{ (mypost) in
            self.post = mypost
            print(self.post.email,"email",mypost)
            self.tableView.backgroundColor = Constants.footer
            self.tableView.tableFooterView = UIView()
            self.navigationController?.navigationBar.barTintColor = Constants.background
            self.navigationController?.title = "Login"
            self.tableView.reloadData()
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.view.addSubview(self.tableView)
            self.tableView.snp.makeConstraints{
                (make) -> Void in
                make.size.equalToSuperview()
            }
            self.navigationItem.hidesBackButton = true
            let button = UIButton()
            button.addTarget(self, action: #selector(self.editProfile), for: .touchUpInside)
            let buttonImage = UIImageView(image: UIImage(named: "edit-32"))
            button.addSubview(buttonImage)
            buttonImage.snp.makeConstraints{
                (make) -> Void in
                make.centerY.equalToSuperview()
                make.centerX.equalToSuperview()
                make.width.equalTo(30)
                make.height.equalTo(30)
            }
            let rightButton = UIBarButtonItem.init(customView : button)
            self.navigationItem.rightBarButtonItem = rightButton
            
            
            
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            self.tableView = UITableView.init(frame: self.view.frame, style: .grouped)
            //self.tableView.separatorStyle = .none
        }
        

        
        // Do any additional setup after loading the view.
    }
    @objc func editProfile() {
        navigationController?.pushViewController(EditProfile(), animated: true)
        
        // Implement action
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 100
        }else{
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myView = UIView()
        let ava = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let myName = UILabel()
        let email = UILabel()
        let cash = UILabel()
        
        
        if section == 0{
           
            myView.addSubview(ava)
            myView.addSubview(myName)
            myView.addSubview(email)
            myView.addSubview(cash)
            myView.backgroundColor = UIColor.white
            
//            ava.setRounded()
//            ava.layer.borderWidth = 1
//            ava.layer.borderColor = UIColor.black.cgColor
            
            
            ava.layer.borderWidth = 0.5
            ava.layer.masksToBounds = false
            ava.layer.borderColor = UIColor.lightGray.cgColor
            ava.layer.cornerRadius = 39
            ava.clipsToBounds = true
            
            ava.snp.makeConstraints{
                (make) -> Void in
                make.height.equalToSuperview().multipliedBy(0.8)
                make.width.equalTo(ava.snp.height)
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(10)
            }
            
            let bottomBorder: UIView = UIView()
            
            myView.addSubview(bottomBorder)
            
            bottomBorder.backgroundColor = UIColor.lightGray
            bottomBorder.snp.makeConstraints({ (make) in
                make.bottom.equalToSuperview().offset(0)
                make.width.equalToSuperview()
                make.height.equalTo(0.7)
            })
            
            
            
            
            let url = self.post.imageUrl
            print("myURl",url)
            ava.kf.setImage(with: URL.init(string: url))
            print(self.post.name,"post name")
            myName.text = "\(String(describing: post.name)) \(String(describing: post.surname))"
            email.text = post.email
           
            
            
            
            myName.textColor = UIColor.black
            myName.font = UIFont(name: "AppleSDGothicNeo-Regular", size:19)
            myName.snp.makeConstraints{
                (make) -> Void in
                make.top.equalTo(ava.snp.top).offset(2)
                make.left.equalTo(ava.snp.right).offset(10)
                make.right.equalToSuperview().offset(-5)
            }
            email.font = UIFont(name: "AppleSDGothicNeo-Regular", size:18)
            email.textColor =  UIColor.gray
            email.snp.makeConstraints{
                (make) -> Void in
                make.left.equalTo(ava.snp.right).offset(10)
                make.centerY.equalTo(ava.snp.centerY)
                make.right.equalToSuperview().offset(-10)
                
            }
            cash.textColor = UIColor.white
            cash.font = UIFont.init(name:"helvetica",size: 17)
            cash.snp.makeConstraints{
                (make) -> Void in
                make.height.equalTo(30)
                make.bottom.equalTo(ava.snp.bottom).offset(0)
                make.left.equalTo(ava.snp.right).offset(5)
                make.right.equalToSuperview().offset(-10)
            }
        }
        return myView

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch indexPath.section{
        
        case 0:
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            switch indexPath.row{
            case 0:
                cell.textLabel?.text = "Пополнить баланс"
            case 1:
                 cell.textLabel?.text = "История бронирований"
            case 2:
                 cell.textLabel?.text = "Активные"
            case 3:
                 cell.textLabel?.text = "Поддержка клиентов"
            default:
                cell.textLabel?.text = "Оценить приложение"

            }
        default:
            cell.textLabel?.textColor = UIColor.red
            cell.textLabel?.text = "Выйти"
            
        }
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 5
        }else{
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let acc = LoginView()
        if indexPath.section == 1{
            
            let optionMenu = UIAlertController(title: nil, message: "Вы уверены что хотите выйти?", preferredStyle: .actionSheet)
           
            
            
            let third = UIAlertAction(title: "Выйти", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                UserDefaults.standard.removeObject(forKey: "token")
                UserDefaults.standard.removeObject(forKey: "userId")

                self.addChildViewController(acc)
                self.view.addSubview(acc.view)
                acc.didMove(toParentViewController: self)
                
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                (alert: UIAlertAction!) -> Void in
            })
            let first = UIAlertAction(title: "Пополнить баланс", style:.default, handler: {
                (alert: UIAlertAction!) -> Void in
                let viewToAnimate = UIView()
                
                UIView.animate(withDuration: 1, delay: 1, options: .curveEaseIn, animations: {
                    viewToAnimate.alpha = 0
                }) { _ in
                    viewToAnimate.removeFromSuperview()
                }
                
            })
            
            
           
            optionMenu.addAction(third)
            optionMenu.addAction(cancelAction)
            optionMenu.addAction(first)
            
            self.present(optionMenu, animated: true, completion: nil)
            
        }
    }
//    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
//        if let header = view as? UITableViewHeaderFooterView {
//            header.backgroundView?.backgroundColor = Constants.footer
//        }
//    }
    
}




