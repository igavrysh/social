//
//  ProfileController.swift
//  ios_social
//
//  Created by new on 1/12/20.
//  Copyright © 2020 Ievgen Gavrysh. All rights reserved.
//

import LBTATools
import Alamofire

extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let height = estimatedCellHeight(for: indexPath, cellWidth: view.frame.width)
        return .init(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class ProfileController: LBTAListController<UserPostCell, Post> {
    
    let userId: String
    
    init(userId: String) {
        self.userId = userId
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUserProfile()
    }
    
    fileprivate func fetchUserProfile() {
        let url = "\(Service.shared.baseUrl)/user/\(userId)"
        
        Alamofire.request(url)
            .validate(statusCode: 200..<300)
            .responseData { (dataResp) in
            //self.activityIndicatorView.stopAnimating
            
            if let err = dataResp.error {
                print("Failed to fetch user profile: ", err)
                return
            }
            
            let data = dataResp.data ?? Data()
            
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                self.items = user.posts ?? []
                //self.user = user
                //self.items = user.posts ?? []
                self.collectionView.reloadData()
            } catch {
                print("Failed to decode user: ", error)
            }
        }
    }
}
