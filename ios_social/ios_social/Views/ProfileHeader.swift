//
//  ProfileHeader.swift
//  ios_social
//
//  Created by new on 1/12/20.
//  Copyright © 2020 Ievgen Gavrysh. All rights reserved.
//

import LBTATools

class ProfileHeader: UICollectionReusableView {
    
    let profileImageView = CircularImageView(width: 80)
    
    let followButton = UIButton(
        title: "Follow",
        titleColor: .black,
        font: .boldSystemFont(ofSize: 13),
        target: self,
        action: #selector(handleFollow))
    
    let editProfileButton = UIButton(
        title: "EditProfile",
        titleColor: .white,
        font: .boldSystemFont(ofSize: 13),
        backgroundColor: .init(red: 0.24, green: 0.67, blue: 0.96, alpha: 1),
        target: self,
        action: #selector(handleEditProfile))
    
    let postsCountLabel = UILabel(
        text: "12",
        font: .boldSystemFont(ofSize: 14),
        textAlignment: .center)
    let postsLabel = UILabel(
        text: "posts",
        font: .systemFont(ofSize: 13),
        textColor: .lightGray,
        textAlignment: .center)
    
    let followersCountLabel = UILabel(text: "500", font: .boldSystemFont(ofSize: 14), textAlignment: .center)
    let followersLabel = UILabel(
        text: "followers",
        font: .systemFont(ofSize: 13),
        textColor: .lightGray,
        textAlignment: .center)
    
    let followingCountLabel = UILabel(text: "500", font: .boldSystemFont(ofSize: 14), textAlignment: .center)
    let followingLabel = UILabel(
        text: "following",
        font: .systemFont(ofSize: 13),
        textColor: .lightGray,
        textAlignment: .center)
    
    let fullnameLabel = UILabel(text: "Username", font: .boldSystemFont(ofSize: 14))
    let bioLabel = UILabel(
        text: "Here's an interesting piece of  bio that will definitely capute your attention and all the fans around the world.",
        font: .systemFont(ofSize: 13),
        textColor: .darkGray,
        numberOfLines: 0)
    
    
    let fullNameLabel = UILabel(
        text: "Full name",
        font: .boldSystemFont(ofSize: 14),
        textColor: .black,
        textAlignment: .center)
    
    var user: User! {
        didSet {
            profileImageView.sd_setImage(with: URL(string: user.profileImageUrl ?? ""))
            profileImageView.image = UIImage(named: "user")
            fullnameLabel.text = user.fullName
            
            bioLabel.text = user.bio
            
            followButton.setTitle(user.isFollowing == true ? "Unfollow" : "Follow", for: .normal)
            followButton.backgroundColor = user.isFollowing == true ? .black : .white
            followButton.setTitleColor(user.isFollowing == true ? .white : .black, for: .normal)
            
            if user.isEditable == true {
                followButton.removeFromSuperview()
            } else {
                editProfileButton.removeFromSuperview()
            }
            
            postsCountLabel.text = "\(user.posts?.count ?? 0)"
            followersCountLabel.text = "\(user.followers?.count ?? 0)"
            followingCountLabel.text = "\(user.following?.count ?? 0)"
        }
    }
    
    weak var profileController: ProfileController?
    
    let separatorView = UIView(backgroundColor: .init(white: 0.4, alpha: 0.3))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        profileImageView.isUserInteractionEnabled = true
    
        profileImageView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(handleEditProfile)))
        
        followButton.layer.cornerRadius = 15
        followButton.layer.borderWidth = 1
        
        profileImageView.layer.cornerRadius = 40
        profileImageView.layer.borderWidth = 1
        
        editProfileButton.layer.cornerRadius = 15
        editProfileButton.layer.borderWidth = 1
                
        stack(
            profileImageView,
            followButton.withSize(.init(width: 100, height: 28)),
            editProfileButton.withSize(.init(width: 100, height: 28)),
            hstack(
                stack(postsCountLabel, postsLabel),
                stack(followersCountLabel, followersLabel),
                stack(followingCountLabel, followingLabel),
                spacing: 16,
                alignment: .center
            ),
            fullnameLabel,
            bioLabel,
            spacing: 12,
            alignment: .center).withMargins(.allSides(14))
        
        addSubview(separatorView)
        separatorView.anchor(
            top: nil,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            size: .init(width: 0, height: 0.5))
    }
    
    @objc fileprivate func handleFollow() {
        profileController?.handleFollowUnfollow()
    }
    
    @objc fileprivate func handleEditProfile() {
        profileController?.changeProfileImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
