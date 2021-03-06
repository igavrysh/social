//
//  Post.swift
//  ios_social
//
//  Created by new on 1/6/20.
//  Copyright © 2020 Ievgen Gavrysh. All rights reserved.
//

import Foundation

struct Post: Decodable {
    let id: String
    let text: String
    let createdAt: Int
    let user: User
    let imageUrl: String
    
    let fromNow: String?
    
    var comments: [Comment]?
    
    var hasLiked: Bool?
    
    var numLikes: Int
}


