//
//  PitchesFetch.swift
//  reserve.kz
//
//  Created by User on 10.04.18.
//  Copyright © 2018 User. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON

class PitchesFetch{
    var id: String?
    var title: String?
    var address: String?
    var latitude = String()
    var longitude =  String()
    var price =  Int()
    var rating = String()
    var site_type: String?
    var coating: String?
    var information: String?
    var from_work_time: String?
    var to_work_time: String?
    var imageUrl: String?
    
    static func fetchPosts(completionHandler: @escaping ([PitchesFetch]) -> ()){
        print("fetchinf appeared first")
        let url = "http://reservation.ga/api/fpitch"
        
        var post = [PitchesFetch]()
        
        Alamofire.request(url, method: .get).validate().responseJSON(completionHandler: {
            response in
            switch response.result{
            case .success:
                if let value = response.result.value{
                    let json = JSON(value)
                    

                    for datas in json["pitch"].arrayValue{
                        let posts = PitchesFetch()

                        posts.id = datas["id"].stringValue
                        posts.title = datas["title"].stringValue
                        posts.address = datas["address"].stringValue
                        posts.latitude = datas["latitude"].stringValue
                        posts.longitude = datas["longitude"].stringValue
                        posts.price = Int(datas["price"].stringValue)!
                        posts.rating = datas["rating"].stringValue
                        posts.site_type = datas["site_type"].stringValue
                        posts.coating = datas["coating"].stringValue
                        posts.information = datas["information"].stringValue
                        posts.from_work_time = datas["from_work_time"].stringValue
                        posts.to_work_time = datas["to_work__time"].stringValue
                        posts.imageUrl = datas["image_by_link"].stringValue
                        post.append(posts)
                    }
                    completionHandler(post)
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        })
    }
}
