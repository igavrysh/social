//
//  User.swift
//  ios_social
//
//  Created by new on 1/14/20.
//  Copyright © 2020 Ievgen Gavrysh. All rights reserved.
//

import Foundation

struct User: Decodable {
    let id: String
    let fullName: String
    var isFollowing: Bool?
    
    var bio, profileImageUrl: String?
    
    var following, followers: [User]?
    
    var posts: [Post]?
    
    var isEditable: Bool?
}
