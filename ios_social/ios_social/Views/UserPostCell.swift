//
//  UserPostCell.swift
//  ios_social
//
//  Created by new on 1/12/20.
//  Copyright © 2020 Ievgen Gavrysh. All rights reserved.
//

import LBTATools

class UserPostCell: LBTAListCell<Post> {

    let usernameLabel = UILabel(text: "Username", font: .boldSystemFont(ofSize: 15))
    let postImageView = UIImageView(image: nil, contentMode: .scaleAspectFit)
    let postTextLabel = UILabel(
        text: "Post text spanning multiple lines",
        font: .systemFont(ofSize: 15),
        numberOfLines: 0)
    
    lazy var optionsButton = UIButton(
        image: UIImage(named: "post_options") ?? UIImage(),
        tintColor: .black,
        target: self,
        action: #selector(handleOptions))
    
    lazy var commentButton = UIButton(image: UIImage(named: "comment-buble") ?? UIImage(), tintColor: .black, target: self, action: #selector(handleComment))
    lazy var likeButton = UIButton(image: UIImage(named: "likeOutline") ?? UIImage(), tintColor: .black, target: self, action: #selector(handleLike))
    
    @objc fileprivate func handleOptions() {
        
    }
    
    @objc fileprivate func handleComment() {
        
    }
    
    @objc fileprivate func handleLike() {
        
    }
    
    override var item: Post! {
        didSet {
            usernameLabel.text = item.user.fullName
            postImageView.sd_setImage(with: URL(string: item.imageUrl))
            postTextLabel.text = item.text
        }
    }
    
    var imageHeightAnchor: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageHeightAnchor.constant = frame.width
    }
    
    override func setupViews() {
        // make image square
        imageHeightAnchor = postImageView.heightAnchor.constraint(equalToConstant: 0)
        imageHeightAnchor.isActive = true
        
        stack(
            hstack(
                usernameLabel,
                UIView(),
                optionsButton.withWidth(34)).padLeft(16).padRight(16),
            postImageView,
            stack(
                postTextLabel).padLeft(16).padRight(16),
            spacing:16).withMargins(.init(top: 16, left: 0, bottom: 16, right: 0))
    }
}
