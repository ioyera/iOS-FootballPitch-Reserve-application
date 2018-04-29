//
//  ScheduleView.swift
//  reserve.kz
//
//  Created by Yerassyl Duisenbi on 16.04.2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import SnapKit
import FontAwesome_swift
import SkyFloatingLabelTextField

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
    
}

class ScheduleView: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var tableView = UITableView()
    var post = [BusyFetch]()
    var image : UIImage = UIImage(named: "angle-right")!

    
    
    //    var tableViewData = [cellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reserved"
        BusyFetch.fetchPosts { (make) in
            self.post = make
            self.view.addSubview(self.tableView)
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            self.tableView.snp.makeConstraints { (make) in
                make.size.equalToSuperview()
                make.center.equalToSuperview()
            }
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return post.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if post[section].opened == true{
            return post[section].fromTime.count + 1
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataSection = indexPath.row - 1
        
        
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            //            cell.textLabel?.backgroundColor = UIColor.lightGray
            cell.textLabel?.text = post[indexPath.section].date
            let expend:UILabel = UILabel()
            expend.text = String.fontAwesomeIcon(name: .angleRight)
            expend.textColor = UIColor.lightGray
//            expend.rightAnchor.constraint(equalTo: right)
            
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = post[indexPath.section].fromTime[dataSection] + " - " + post[indexPath.section].toTime[dataSection]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if post[indexPath.section].opened == true{
                post[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }else{
                
                post[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
    }
    
}
