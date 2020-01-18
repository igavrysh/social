//
//  Service.swift
//  ios_social
//
//  Created by new on 1/6/20.
//  Copyright © 2020 Ievgen Gavrysh. All rights reserved.
//

import Alamofire

class Service: NSObject {
    
    static let shared = Service()
    
    //let baseUrl = "http://localhost:1337"
    let baseUrl = "https://socialapp-igavrysh.herokuapp.com"
    
    func login(email: String, password: String, completion: @escaping (Result<Data>) -> ()) {
        print("Performing login")
        let url = "\(baseUrl)/api/v1/entrance/login"
        let params = ["emailAddress": email, "password": password]
        
        Alamofire.request(url, method: .put, parameters: params)
            .validate(statusCode: 200..<300)
            .response { (dataResponse) in
                if let err = dataResponse.error {
                    completion(.failure(err))
                    return
                } else {
                    completion(.success(dataResponse.data ?? Data()))
                }
            }
    }
    
    func fetchPosts(completion: @escaping (Result<[Post]>) -> ()) {
        let url = "\(baseUrl)/post"
        Alamofire.request(url)
            .validate(statusCode: 200..<300)
            .responseData { (dataResp) in
                if let err = dataResp.error {
                    completion(.failure(err))
                    return
                }
                guard let data = dataResp.data else { return }
                do {
                    let posts = try JSONDecoder().decode([Post].self, from: data)
                    completion(.success(posts))
                } catch {
                    completion(.failure(error))
                }
            }
    }
    
    func signUp(fullName: String, emailAddress: String, password: String, completion: @escaping (Result<Data>) -> ()) {
        let url = "\(baseUrl)/api/v1/entrance/signup"
        let params = ["fullName": fullName, "emailAddress": emailAddress, "password": password]
        Alamofire.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { (dataResp) in
                if let err = dataResp.error {
                    completion(.failure(err))
                    return
                }
                completion(.success(dataResp.data ?? Data()))
            }
    }
    
    func searchForUsers(completion: @escaping (Result<[User]>) -> ()) {
        let url = "\(baseUrl)/search"
        Alamofire.request(url)
            .validate(statusCode: 200..<300)
            .responseData { (dataResponse) in
                if let err = dataResponse.error {
                    completion(.failure(err))
                    return
                }
                
                do {
                    let data = dataResponse.data ?? Data()
                    let users = try JSONDecoder().decode([User].self, from: data)
                    completion(.success(users))
                } catch {
                    completion(.failure(error))
                }
        }
    }
}


