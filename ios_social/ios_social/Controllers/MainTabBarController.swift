//
//  MainTabBarController.swift
//  ios_social
//
//  Created by new on 1/14/20.
//  Copyright © 2020 Ievgen Gavrysh. All rights reserved.
//

import UIKit

extension MainTabBarController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            dismiss(animated: true) {
                let createPostController = CreatePostController(selectedImage: image)
                self.present(createPostController, animated: true)
            }
        } else {
            dismiss(animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var homeController = HomeController()
    var profileController = ProfileController(userId: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        viewControllers = [
            createNavController(viewController: homeController, tabBarImage: UIImage(named: "home")),
            createNavController(
                viewController: UIViewController(),
                tabBarImage: UIImage(named: "plus")),
            createNavController(viewController: profileController, tabBarImage: UIImage(named: "user")),
        ]
    }
    
    fileprivate func createNavController(viewController: UIViewController, tabBarImage: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = tabBarImage
        return navController
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewControllers?.firstIndex(of: viewController) == 1 {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            present(imagePicker, animated: true)
            return false
        }
        
        return true
    }
    
    func refreshPosts() {
        homeController.fetchPosts()
        profileController.fetchUserProfile()
    }
    
}
