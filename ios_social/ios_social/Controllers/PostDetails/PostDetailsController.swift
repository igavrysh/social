//
//  PostDetailsController.swift
//  ios_social
//
//  Created by new on 1/17/20.
//  Copyright © 2020 Ievgen Gavrysh. All rights reserved.
//

import LBTATools
import Alamofire

struct Comment {
    let text: String
    let user: User
    let fromNow: String
}

class CommentCell: LBTAListCell<Comment> {
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .red
    }
    
}

class PostDetailsController: LBTAListController<CommentCell, Comment> {
    
    let postId: String
    
    init(postId: String) {
        self.postId = postId
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPostDetails()
    }
    
    func fetchPostDetails() {
        let url = "\(Service.shared.baseUrl)/post/\(postId)"
        Alamofire.request(url).responseData { (dataResp) in
            //self.activityIndicatorView.stopAnimating()
            guard let data = dataResp.data else { return}
            
            do {
                let post = try JSONDecoder().decode(Post.self, from: data)
                //self.items = post.comments ?? []
                self.collectionView.reloadData()
            } catch {
                print("Failed to parse post: ", error)
            }
        }
    }
}
