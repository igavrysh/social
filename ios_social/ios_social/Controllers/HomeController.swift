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

class HomeController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        
        navigationItem.rightBarButtonItem = .init(title: "Fetch postst", style: .plain, target: self, action: #selector(fetchPosts))
        
        navigationItem.leftBarButtonItem = .init(title: "Login", style: .plain, target: self, action: #selector(handleLogin))
    }
    
    @objc fileprivate func fetchPosts() {
        print("Attempt to fetch post while unauthorized")
        
        guard let url = URL(string: "http://localhost:1337/post") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to hit server: ", err)
                    return
                } else if let resp = resp as? HTTPURLResponse, resp.statusCode != 200 {
                    print("Failed to fetch posts, statusCode: ", resp.statusCode)
                    return
                } else {
                    print("Successfully fetched posts, response data:")
                    let html = String(data: data ?? Data(), encoding: .utf8) ?? ""
                    print(html)
                    let vc = UIViewController()
                    let webView = WKWebView()
                    webView.loadHTMLString(html, baseURL: nil)
                    vc.view.addSubview(webView)
                    webView.fillSuperview()
                    self.present(vc, animated: true)
                }
            }
        }.resume()
    }
    
    @objc func handleLogin() {
        print("Show login and sign up pages")
        let navController = UINavigationController(rootViewController: LoginController())
        present(navController, animated: true)
    }
}
