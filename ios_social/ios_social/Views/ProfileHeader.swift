//
//  ProfileHeader.swift
//  ios_social
//
//  Created by new on 1/12/20.
//  Copyright © 2020 Ievgen Gavrysh. All rights reserved.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
        
    let fullNameLabel = UILabel(text: "Full name", font: .boldSystemFont(ofSize: 14), textColor: .black, textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        
        stack(fullNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
