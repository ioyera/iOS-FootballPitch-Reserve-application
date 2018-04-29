//
//  BronsView.swift
//  reserve.kz
//
//  Created by User on 19.02.18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import SnapKit
import MapKit
import Kingfisher
import GearRefreshControl

class BronsView: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var tableView  = UITableView()
    
    var collView : UICollectionView!
    var map = MKMapView()
    var post = BronFetch()
    var gearRefreshControl: GearRefreshControl!
    
    let cellId = "CellId"
    
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
        BronFetch.fetchProfile{
            (mypost) in
            self.post = mypost
            self.view.addSubview(self.tableView)
            
            self.map.mapType = .standard
            let latitude = Double(self.post.latitude!)
            let longitude = Double(self.post.longitude!)
            print(latitude!)
            let coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            self.map.addAnnotation(anno)
            self.map.setRegion(MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(latitude!, longitude!), 2000, 2000), animated: true)
            
            
            self.tableView.snp.makeConstraints{
                (make) -> Void in
                make.size.equalToSuperview()
                make.center.equalToSuperview()
            }
            self.tableView.allowsSelection = false
            self.tableView.backgroundColor = Constants.footer
            self.tableView.separatorStyle = .none
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(BronsCell.self, forCellReuseIdentifier: "cell")
            self.tableView = UITableView.init(frame: self.view.frame, style: .grouped)
            self.tableView.allowsSelection = false
            // Do any additional setup after loading the view.
            
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            self.collView = UICollectionView.init(frame: self.view.frame, collectionViewLayout: layout)
            self.collView?.delegate = self
            self.collView?.dataSource = self
            self.collView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
            self.collView.isPagingEnabled = true
            
        }
        
    }
 
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 2 :
            return 130
        default:
            return 50
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 200
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.addSubview(collView)
        collView.snp.makeConstraints{
            (make) -> Void in
            make.size.equalToSuperview()
        }
        return headerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BronsCell
        switch indexPath.row{
            
        case 0:
            cell.textLabel?.text = self.post.title
            cell.detailTextLabel?.text = self.post.address
            print(self.post.address,"address")
            
            
        case 1:
            cell.golos.text = "Проголосовали: 465 ⚗︎"
            cell.golos.font = UIFont.init(name: "helvetica", size: 13)
            cell.golos.textColor = UIColor.gray
            cell.rating.text = "♥︎ " + self.post.rating! + "/10"
            cell.price.text = "    \(String(describing: self.post.price!)) kzt/h"
            cell.price.layer.borderWidth = 2

            cell.price.layer.borderColor = Constants.background.cgColor

        case 2:
            let view = UIView()
            let address = UILabel()
            address.text = self.post.address!
            cell.addSubview(map)
            map.snp.makeConstraints{
                (make) -> Void in
                make.size.equalToSuperview()
                make.center.equalToSuperview()
            }
            map.addSubview(view)
            map.addSubview(address)
            address.textAlignment = .center
            address.numberOfLines = 2
            address.font = UIFont.init(name: "helvetica", size: 13)
            address.snp.makeConstraints({ (make) in
                make.bottom.equalTo(map.snp.bottom).offset(0)
                make.width.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(0.15)
            })
            
            view.backgroundColor = UIColor.gray
            view.alpha = 0.2
            view.snp.makeConstraints({ (make) in
                make.bottom.equalTo(map.snp.bottom).offset(0)
                make.width.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(0.15)
                
            })
            map.isScrollEnabled = false
        case 3:
            cell.number.textColor = UIColor.gray
            cell.number.text = "87479819891"
            cell.logo.image = UIImage(named: "call")
        case 4:
            
            cell.contentView.layer.cornerRadius = 20
            cell.contentView.backgroundColor = Constants.footer
            cell.name.textAlignment = .center
            cell.name.font = UIFont.boldSystemFont(ofSize: 15)
            cell.name.text = "Время работы: c \(self.post.from_work_time!) + до \(self.post.to_work_time!)"
        default:
            
            let bronBut = UIButton()
            
            cell.addSubview(bronBut)
           
            
            bronBut.backgroundColor = UIColor.red
            bronBut.backgroundColor = Constants.background
            
            
            bronBut.layer.cornerRadius = 20
            bronBut.tintColor = UIColor.white
            bronBut.setTitle("Бронировать", for: .normal)
            bronBut.titleLabel!.font = UIFont.boldSystemFont(ofSize: 16)
            
            bronBut.snp.makeConstraints{
                (make) -> Void in
                make.left.equalToSuperview().offset(25)
                make.centerY.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(0.6)
                make.height.equalToSuperview().multipliedBy(0.85)
            }
            
            bronBut.addTarget(self, action: #selector(reserveView), for: .touchUpInside)
            
            let callBut = UIButton()
            cell.addSubview(callBut)
            callBut.layer.cornerRadius = 22
            callBut.setImage(UIImage(named:"call1"), for: .normal)
            callBut.backgroundColor = Constants.background
            callBut.imageView?.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.size.equalToSuperview().multipliedBy(0.6)
            }
            callBut.snp.makeConstraints{
                (make) -> Void in
                make.right.equalToSuperview().offset(-25)
                make.height.equalTo(bronBut.snp.height)
                make.width.equalTo(callBut.snp.height)
                make.centerY.equalToSuperview()
            }
            callBut.addTarget(self, action: #selector(actionSheet), for: .touchUpInside)
        }
        return cell
        
    }
    @objc func actionSheet(){
        
        let optionMenu = UIAlertController()
        
        let first = UIAlertAction(title: "87479819891", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        let second = UIAlertAction(title: "87777777777", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        let third = UIAlertAction(title: "87478278272", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        
        optionMenu.addAction(first)
        optionMenu.addAction(second)
        optionMenu.addAction(third)
        optionMenu.addAction(cancelAction)

        self.present(optionMenu, animated: true, completion: nil)

        
    }
    @objc func reserveView(){
        
        navigationController?.pushViewController(ReserveView(), animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    //-----------------------------------------------
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post.imageUrls.count
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.view.frame.width, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CollectionViewCell
        print(self.post.imageUrls,"photos")
        let url = URL.init(string: self.post.imageUrls[indexPath.item])
        
        
        cell.images.kf.setImage(with: url)
        return cell
    }
}

class CollectionViewCell: UICollectionViewCell{
    let images = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        elements()
    }
    
    func elements(){
        addSubview(images)
        images.snp.makeConstraints{
            (make) -> Void in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
}

