//
//  BronFetch.swift
//  reserve.kz
//
//  Created by User on 10.04.18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BronFetch{
    var id = String()
    var title: String?
    var address: String?
    var latitude: String?
    var longitude: String?
    var price: String?
    var rating: String?
    var site_type: String?
    var coating: String?
    var information: String?
    var from_work_time: String?
    var to_work_time: String?
    var photoUrl: String?
    var imageUrls = [String]()
    static func fetchProfile(completionHandler: @escaping (BronFetch) -> ()){
        let id = UserDefaults.standard.value(forKey: "id")
        let posts = BronFetch()
        let url = "http://reservation.ga/api/fpitch/\(id as! String)"
        Alamofire.request(url, method: .get).validate().responseJSON(completionHandler: {
            response in
            switch response.result{
            case .success:
                if let value = response.result.value{
                    let json = JSON(value)
                    print(url,"url")
                    print("success",json)
                    posts.title = json["client"]["title"].stringValue
                    posts.address = json["client"]["address"].stringValue
                    posts.latitude = json["client"]["latitude"].stringValue
                    posts.longitude = json["client"]["longitude"].stringValue
                    posts.price = json["client"]["price"].stringValue
                    posts.rating = json["client"]["rating"].stringValue
                    posts.site_type = json["client"]["site_type"].stringValue
                    posts.coating = json["client"]["coating"].stringValue
                    posts.information = json["client"]["information"].stringValue
                    posts.from_work_time = json["client"]["from_work_time"].stringValue
                    posts.to_work_time = json["client"]["to_work_time"].stringValue
                    
                    for datas in json["client"]["images"].arrayValue{
                        print(datas,"datass")
                        
                        posts.photoUrl = datas.stringValue
                        posts.imageUrls.append(posts.photoUrl!)
                    }
                    completionHandler(posts)
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        })
        
        
    }
    
}
