//
//  MainTabBarController.swift
//  ios_social
//
//  Created by new on 1/14/20.
//  Copyright © 2020 Ievgen Gavrysh. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavController(viewController: HomeController(), tabBarImage: UIImage(named: "home")),
            createNavController(viewController: CreatePostController(selectedImage: UIImage(named: "startup") ?? UIImage()), tabBarImage: UIImage(named: "plus")),
            createNavController(viewController: ProfileController(userId: ""), tabBarImage: UIImage(named: "user")),
            
            
        ]
    }
    
    fileprivate func createNavController(viewController: UIViewController, tabBarImage: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = tabBarImage
        return navController
    }
}
