//
//  BusyFetch.swift
//  reserve.kz
//
//  Created by Yerassyl Duisenbi on 15.04.2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BusyFetch{
    var opened: Bool = false
    var date = String()
    var fromTime = [String()]
    var toTime = [String()]
//    var time = [String(), String()]
    var expanded = false
    static func fetchPosts(completionHandler: @escaping ([BusyFetch]) -> ()){
        print("fetchinf appeared first")
        let id = UserDefaults.standard.value(forKey: "id")
        let url = "http://reservation.ga/api/booking/3"
        
        var post = [BusyFetch]()
        
        Alamofire.request(url, method: .get).validate().responseJSON(completionHandler: {
            response in
            switch response.result{
            case .success:
                if let value = response.result.value{
                    let json = JSON(value)
                    
                    if json["status"].stringValue == "success"{
                        print("success")
                        for datas in json["booking"].arrayValue{
                            let posts = BusyFetch()
                            print(datas)
                            
                            posts.date = datas["date"].stringValue
//                            posts.time = [datas["from_time"].stringValue, datas["to_time"].stringValue]
                            posts.fromTime = [datas["from_time"].stringValue]
                            posts.toTime = [datas["to_time"].stringValue]
//                            posts.time = [posts.fromTime, posts.toTime]
                            
                            post.append(posts)
                        }
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
