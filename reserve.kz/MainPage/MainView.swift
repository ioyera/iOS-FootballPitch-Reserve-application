//
//  MainView.swift
//  reserve.kz
//
//  Created by User on 12.04.18.
//  Copyright © 2018 User. All rights reserved.
//


import UIKit
import SnapKit
import Kingfisher
import CoreLocation
import MapKit
import GearRefreshControl

class MainView: UIViewController ,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,CLLocationManagerDelegate{
    let locationManager = CLLocationManager()
    var places = [PitchesFetch]()
    var filteredPlaces = [PitchesFetch]()
    
    
    
    let button = UIButton()
    var mysearch = UISearchController()
    var tableView = UITableView()
    var popUpAppend = false
    var whichRow: Int = 0
    var gearRefreshControl: GearRefreshControl!
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }

    override func viewDidAppear(_ animated: Bool) {
        print("popoqpwoe")
        //
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

        self.title = "reserve.kz"
        
        self.tableView.backgroundColor = Constants.footer
        
        
//        for datas in places{
//            let rate = String(describing: datas.rating)
//            var filterByRating  = Double(rate)
//            print(filterByRating,"rating")
//
//            filteredPlaces  = places.sort(by: {$0.rating > $1.rating)
//            print(places.sort(by: {$0.rate > $1.rate)
//
//
////            filteredPlaces = places
////            print(places.sort(by: {$0.filterByRating > $1.filterByRating,"filtered placess")
////            var filteredByDistance = [PitchesFetch] = datas.
//        }
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints{
            (make) -> Void in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.barTintColor = Constants.background
        let buttonImage = UIImageView(image: UIImage(named: "menu1"))
        buttonImage.tintColor = UIColor.white
        
        button.tintColor = UIColor.white
        button.addSubview(buttonImage)
        buttonImage.snp.makeConstraints{
            (make) -> Void in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        let rightButton = UIBarButtonItem.init(customView : button)
        navigationItem.leftBarButtonItem = rightButton
        button.addTarget(self, action: #selector(showPopUp), for: .touchUpInside)
        
        mysearch = UISearchController(searchResultsController: nil)
        mysearch.searchBar.sizeToFit()
        mysearch.searchBar.barTintColor = Constants.background
        filteredPlaces = places
        mysearch.searchResultsUpdater = self
        mysearch.dimsBackgroundDuringPresentation = false
        mysearch.hidesNavigationBarDuringPresentation = true
        definesPresentationContext = true
        tableView.tableHeaderView = mysearch.searchBar
        
        tableView.register(MainCell.self, forCellReuseIdentifier: "cell")
        
    }

    @objc func showPopUp(){
        let popUp = PopUpView()

        if popUpAppend == false {
            popUp.barButton = self.button
            self.popUpAppend = true
            self.addChildViewController(popUp)
            popUp.view.frame = self.tableView.frame
            self.view.addSubview(popUp.view)
            popUp.didMove(toParentViewController: self)
        }else{
            popUp.view.removeFromSuperview()
            popUpAppend = false
            
        }
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text! == ""{
            filteredPlaces = places
        }else{
            filteredPlaces = places.filter({($0.title?.lowercased().contains(searchController.searchBar.text!.lowercased()))!})
        }
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainCell
        cell.name.text = filteredPlaces[indexPath.row].title
        
        let url = URL(string: "http://\(filteredPlaces[indexPath.row].imageUrl as! String )")
        let myView = UIView()
        myView.alpha = 1
        
        cell.selectedBackgroundView = myView
        cell.logo.kf.setImage(with: url)
        cell.favor.addTarget(self, action: #selector(myFavor), for: .touchUpInside)
        cell.price.text =   "     \(filteredPlaces[indexPath.row].price)тг/ч"
        //cell.distance.text = filteredPlaces[indexPath.row].distance + "km"
        
        cell.rating.text = "♥︎ " + filteredPlaces[indexPath.row].rating + "/10"
        cell.address.text = filteredPlaces[indexPath.row].address!
        cell.favor.setImage(UIImage(named: "notfavor"), for: .normal)
        return cell
    }
    
    @objc func myFavor(){
        
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPlaces.count
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pitch_id = tableView.indexPathForSelectedRow?.row
        let bronsView = BronsView()
        UserDefaults.standard.setValue((String(describing: (pitch_id! + 1))), forKey: "id")
        self.navigationController?.pushViewController(bronsView, animated: true)

       
        
        
    }
    
}
