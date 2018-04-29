//
//  AccountFetch.swift
//  reserve.kz
//
//  Created by User on 09.04.18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AccountFetch{
    var id = String()
    var name = String()
    var surname = String()
    var email =  String()
    var number =  String()
    var phone = String()
    var imageUrl = String()
    static func fetchProfile(completionHandler: @escaping (AccountFetch) -> ()){
        
        let token : String = UserDefaults.standard.string(forKey: "token")!
        let url = "http://reservation.ga/api/client/token/\(token)"
        print(url)
        let posts = AccountFetch()
        Alamofire.request(url, method: .get).validate().responseJSON(completionHandler: {
            response in
            switch response.result{
            case .success:
                if let value = response.result.value{
                    let json = JSON(value)
                    if json["status"].stringValue == "success"{
                        posts.id = json["client"]["id"].stringValue
                        posts.name = json["client"]["name"].stringValue
                        posts.phone = json["client"]["phone"].stringValue
                        posts.surname = json["client"]["surname"].stringValue
                        posts.email = json["client"]["email"].stringValue
                        posts.number = json["client"]["number"].stringValue
                        posts.imageUrl = json["client"]["image_by_link"].stringValue
                        completionHandler(posts)
                        
                    }else{
                        print("Some error while fetching profile data")
                    }
                    

                    
                }
                
                break
            case .failure(let error):
                print(error.localizedDescription)
                
                break
            }
        })
        
        
    }
    
}
