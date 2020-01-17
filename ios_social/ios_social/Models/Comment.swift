//
//  Comment.swift
//  ios_social
//
//  Created by new on 1/17/20.
//  Copyright © 2020 Ievgen Gavrysh. All rights reserved.
//

import Foundation

struct Comment: Decodable {
    let text: String
    let user: User
    let fromNow: String
}
