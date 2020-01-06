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

struct Post: Decodable {
    let id: String
    let text: String
    let createdAt: Int
    let user: User
}

struct User: Decodable {
    let id: String
    let fullName: String
}

class HomeController: UITableViewController {
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showCookies()
                
        navigationItem.rightBarButtonItem = .init(title: "Fetch postst", style: .plain, target: self, action: #selector(fetchPosts))
        
        navigationItem.leftBarButtonItem = .init(title: "Login", style: .plain, target: self, action: #selector(handleLogin))
    }
    
    fileprivate func showCookies() {
        HTTPCookieStorage.shared.cookies?.forEach({ (cookie) in
            print(cookie)
        })
    }
    
    @objc fileprivate func fetchPosts() {
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
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.user.fullName
        cell.textLabel?.font = .boldSystemFont(ofSize: 14)
        cell.detailTextLabel?.text = post.text
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
}
