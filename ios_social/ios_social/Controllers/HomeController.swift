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
        
        showCookies()
                
        navigationItem.rightBarButtonItem = .init(
            title: "Fetch postst",
            style: .plain,
            target: self,
            action: #selector(fetchPosts))
        
        navigationItem.rightBarButtonItems = [
            .init(title: "Fetch posts", style: .plain, target: self, action: #selector(fetchPosts)),
            .init(title: "Create post", style: .plain, target: self, action: #selector(createPost))
        ]
        
        navigationItem.leftBarButtonItem = .init(
            title: "Login",
            style: .plain,
            target: self,
            action: #selector(handleLogin))
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
        let url = "http://localhost:1337/post"
        Alamofire.request(url)
            .validate(statusCode: 200..<300)
            .responseData { (dataResp) in
                if let err = dataResp.error {
                    print("Failed to fetch posts: ", err)
                    return
                }
                
                guard let data = dataResp.data else { return }
                do {
                    let posts = try JSONDecoder().decode([Post].self, from: data)
                    self.posts = posts
                    self.tableView.reloadData()
                } catch {
                    print(error)
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
