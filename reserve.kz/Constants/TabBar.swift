//
//  TabBar.swift
//  reserve.kz
//
//  Created by User on 05.02.18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import Lottie

class TabBar: UITabBarController,UITabBarControllerDelegate{
    let mainView = MainView()
    let map = MapView()
    var account = UINavigationController.init(rootViewController: LoginView())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        PitchesFetch.fetchPosts{ (posts) in
            self.mainView.places = posts
            self.map.post = posts
            let acc = AccountView()
            let token = UserDefaults.standard.string(forKey: "token")
            print(token,"my token")
            
            if token == nil{
                print("Token is empty, profile not loginned",token)
                
            }else{
                self.account = UINavigationController.init(rootViewController: acc)
            }
            self.loading()
        }

        
        // Do any additional setup after loading the view.
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        
        if tabBarIndex == 2 {
            //do your stuff
        }
    }
    
    
    func loading(){
        let main = UINavigationController.init(rootViewController: mainView)

        main.title = "Top Rated"
        main.tabBarItem = UITabBarItem.init(tabBarSystemItem: .favorites, tag: 0)
        let map = UINavigationController.init(rootViewController: self.map)
        map.title = "Map"
        map.tabBarItem = UITabBarItem.init(tabBarSystemItem: .favorites, tag: 1)
        print(account)
        account.title = "Account"
        account.tabBarItem = UITabBarItem.init(tabBarSystemItem: .bookmarks , tag: 2)
        let tabs = [main,map,account]
        self.viewControllers = tabs
    }
}
