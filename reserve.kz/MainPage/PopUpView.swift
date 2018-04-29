//
//  PopUpView.swift
//  reserve.kz
//
//  Created by User on 13.02.18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import SnapKit

class PopUpView: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var data =  ["По рейтингу" ,"По самой ближайщей","Избранное"]
    var icons = [UIImage(named: "byRating")!,UIImage(named:"byDistance")!,UIImage(named:"favor")!]
    var tableView = UITableView()
    var navBar = UINavigationBar()
    var barButton = UIButton()
    var whichRow: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        tableView.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PopUpCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundView?.isOpaque = true
        
//        let view = UIView()
//        view.backgroundColor = Constants.background
//        tableView.tableFooterView = view
        tableView.backgroundColor = UIColor.clear
        tableView.isScrollEnabled = false
        
        self.barButton.addTarget(self, action: #selector(closePopUp), for: .touchUpInside)
        //self.modalPresentationStyle = .overCurrentContext
        self.view.addSubview(navBar)
        self.view.addSubview(tableView)
        
    }
    func hideView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc  func dismissView() {
        view.removeFromSuperview()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       // view.removeFromSuperview()
        dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PopUpCell
        
        cell.label.text = data[indexPath.row]
        cell.label.textColor = UIColor.gray
        cell.myImage.image = icons[indexPath.row]
        cell.myImage.tintColor = UIColor.gray
        cell.backgroundColor = Constants.footer
       
        
        return cell
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    @objc func closePopUp(){
        
        let main = MainView()
        self.view.removeFromSuperview()
        main.popUpAppend = false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .checkmark
        self.view.removeFromSuperview()
        let main = MainView()
        main.tableView.reloadData()
        main.popUpAppend = false
        let selected = self.tableView.indexPathForSelectedRow?.row
        self.whichRow = selected!
        main.whichRow = selected!
        
        if whichRow == 0{
            main.filteredPlaces = main.places.sorted{
                $0.rating < $1.rating
            }
        }else if whichRow == 1{
            main.filteredPlaces = main.places.sorted{
                $0.rating > $1.rating
            }
        }else if whichRow == 2{
            main.filteredPlaces = main.places.sorted{
                $0.rating < $1.rating
            }
        }
        
        for i in main.places{
            print(i.address)
        }
        main.tableView.reloadData()
        self.tableView.reloadData()
        
    }

    

}


class PopUpCell: UITableViewCell{
    let myImage = UIImageView()
    let label = UILabel()
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        elements()
        
    }
    func elements(){
        addSubview(myImage)
        
        addSubview(label)
        myImage.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.6)
            make.width.equalTo(myImage.snp.height)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(myImage.snp.right).offset(15)
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            
        }
    }
    
}
