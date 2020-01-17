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

class HomeController: LBTAListController<UserPostCell, Post>,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate
{
        
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
        
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(fetchPosts), for: .valueChanged)
        self.collectionView.refreshControl = rc
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
            self.collectionView.refreshControl?.endRefreshing()
            switch res {
            case .failure(let err):
                print("Failed to fetch posts: ", err)
            case .success(let posts):
                self.items = posts
                self.collectionView.reloadData()
            }
        }
    }
    
    @objc func handleLogin() {
        print("Show login and sign up pages")
        let navController = UINavigationController(rootViewController: LoginController())
        present(navController, animated: true)
    }
    
    func handleShowPostDetailsAndComments(post: Post) {
        let postDetailsController = PostDetailsController(postId: post.id)
        navigationController?.pushViewController(postDetailsController, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        
        dismiss(animated: true) {
            let createPostController = CreatePostController(selectedImage: image)
            createPostController.homeController = self
            self.present(createPostController, animated: true)
        }
    }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let height = estimatedCellHeight(for: indexPath, cellWidth: view.frame.width)
        return .init(width: view.frame.width, height: height)
    }
}
