//
//  HomeController.swift
//  ios_social
//
//  Created by new on 1/3/20.
//  Copyright © 2020 Ievgen Gavrysh. All rights reserved.
//

import UIKit
import WebKit
import LBTATools
import Alamofire
import SDWebImage

class HomeController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPosts()
        
        navigationController?.navigationBar.tintColor = .black
                
        navigationItem.rightBarButtonItem = .init(
            title: "Fetch postst",
            style: .plain,
            target: self,
            action: #selector(fetchPosts))
        
        navigationItem.rightBarButtonItems = [
            .init(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(handleSearch))
            /*,
            .init(title: "Create post", style: .plain, target: self, action: #selector(createPost))
            */
        ]
        
        navigationItem.leftBarButtonItem = .init(
            title: "Login",
            style: .plain,
            target: self,
            action: #selector(handleLogin))
    }
    
    @objc fileprivate func handleSearch() {
        let navController = UINavigationController(rootViewController: UsersSearchController());
        present(navController, animated: true)
    }
    
    @objc fileprivate func createPost() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    fileprivate func showCookies() {
        HTTPCookieStorage.shared.cookies?.forEach({ (cookie) in
            print(cookie)
        })
    }
    
    @objc func fetchPosts() {
        Service.shared.fetchPosts { (res) in
            switch res {
            case .failure(let err):
                print("Failed to fetch posts: ", err)
            case .success(let posts):
                self.posts = posts
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func handleLogin() {
        print("Show login and sign up pages")
        let navController = UINavigationController(rootViewController: LoginController())
        present(navController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PostCell(style: .subtitle, reuseIdentifier: nil)
        let post = posts[indexPath.row]
        
        cell.usernameLabel.text = post.user.fullName
        cell.postTextLabel.text = post.text
        cell.postImageView.sd_setImage(with: URL(string: post.imageUrl))

        cell.delegate = self
        
        return cell
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }
        
        dismiss(animated: true) {
            let createPostController = CreatePostController(selectedImage: image)
            createPostController.homeController = self
            self.present(createPostController, animated: true)
        }
    }
    
}
