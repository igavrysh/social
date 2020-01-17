//
//  UserPostCell.swift
//  ios_social
//
//  Created by new on 1/12/20.
//  Copyright © 2020 Ievgen Gavrysh. All rights reserved.
//

import LBTATools

class UserPostCell: LBTAListCell<Post> {
    
    let profileImageView = CircularImageView(width: 44, image: UIImage(named: "user") ?? UIImage())

    let usernameLabel = UILabel(text: "Username", font: .boldSystemFont(ofSize: 15))
    let postImageView = UIImageView(image: nil, contentMode: .scaleAspectFit)
    let postTextLabel = UILabel(
        text: "Post text spanning multiple lines",
        font: .systemFont(ofSize: 15),
        numberOfLines: 0)
    let fromNowLabel = UILabel(text: "Posted 5d ago", textColor: .gray)
    
    lazy var optionsButton = UIButton(
        image: UIImage(named: "post_options") ?? UIImage(),
        tintColor: .black,
        target: self,
        action: #selector(handleOptions))
    
    lazy var commentButton = UIButton(
        image: UIImage(named: "comment-bubble") ?? UIImage(),
        tintColor: .black,
        target: self,
        action: #selector(handleComment))
    lazy var likeButton = UIButton(
        image: UIImage(named: "like-outline") ?? UIImage(),
        tintColor: .black,
        target: self,
        action: #selector(handleLike))
    
    @objc fileprivate func handleOptions() {
        
    }
    
    @objc fileprivate func handleComment() {
        (parentController as? HomeController)?.handleShowPostDetailsAndComments(post: self.item)
        
    }
    
    @objc fileprivate func handleLike() {
        
    }
    
    override var item: Post! {
        didSet {
            usernameLabel.text = item.user.fullName
            postImageView.sd_setImage(with: URL(string: item.imageUrl))
            postTextLabel.text = item.text
            profileImageView.sd_setImage(with: URL(string: item.user.profileImageUrl ?? ""))
            fromNowLabel.text = item.fromNow
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
                profileImageView,
                stack(
                    usernameLabel,
                    fromNowLabel),
                UIView(),
                optionsButton.withWidth(34),
                spacing: 12).padLeft(16).padRight(16),
            postImageView,
            stack(
                postTextLabel).padLeft(16).padRight(16),
            hstack(
                likeButton,
                commentButton,
                UIView(),
                spacing: 12).padLeft(16),
            spacing:16).withMargins(.init(top: 16, left: 0, bottom: 16, right: 0))
    }
}
