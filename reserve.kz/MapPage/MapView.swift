//
//  TabView.swift
//  reserve.kz
//
//  Created by User on 05.02.18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation


class MapView: UIViewController{
    
    var post =  [PitchesFetch]()
    //    var locationManager: CLLocationManager!
    var map = MKMapView()
    //    var locationManager: CLLocationManager?
    let initialLocation = CLLocation(latitude: 43.222015, longitude: 76.901248)
    let regionRadius: CLLocationDistance = 10000
    
    let locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            map.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for datas in self.post{
            print(Double(datas.latitude)!)
            let artwork = Artwork(title: datas.title!,
                                  locationName: datas.address!,
                                  discipline: "Футбольное поле",
                                  coordinate: CLLocationCoordinate2D(latitude: Double(datas.latitude)!, longitude: Double(datas.longitude)!))
            map.addAnnotation(artwork)
            
            
        }
        checkLocationAuthorizationStatus()
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        map.setRegion(coordinateRegion, animated: true)
    }
    //    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //        let userLocation:CLLocation = locations[0]
    //        let long = userLocation.coordinate.longitude;
    //        let lat = userLocation.coordinate.latitude;
    //
    //        print(long, lat)
    //    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Map"
        self.navigationController?.navigationBar.barTintColor = Constants.background
        print(self.post,"awdoqmwomwd")
        self.view.addSubview(map)
        map.mapType = .standard
        map.delegate = self
        
        map.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
        centerMapOnLocation(location: initialLocation)
        
        
        
        

        
        
    }
    
    
    
    
}
extension MapView: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Artwork else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
