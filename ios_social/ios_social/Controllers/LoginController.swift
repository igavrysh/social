//
//  LoginController.swift
//  ios_social
//
//  Created by new on 1/3/20.
//  Copyright © 2020 Ievgen Gavrysh. All rights reserved.
//

import UIKit
import LBTATools
import Alamofire

class LoginController: LBTAFormController {
    
    // MARK: UI Elements
    
    let logoImageView = UIImageView(image: UIImage(named: "startup"), contentMode: .scaleAspectFit)
    let logoLabel = UILabel(text: "Social", font: .systemFont(ofSize: 32, weight: .heavy), textColor: .black, numberOfLines: 0)
    
    let emailTextField = IndentedTextField(placeholder: "Email", padding: 24, cornerRadius: 25, keyboardType: .emailAddress)
    let passwordTextField = IndentedTextField(placeholder: "Password", padding: 24, cornerRadius: 25)
    lazy var loginButton = UIButton(title: "Login", titleColor: .white, font: .boldSystemFont(ofSize: 18), backgroundColor: .black, target: self, action: #selector(handleLogin))

    let errorLabel = UILabel(text: "Your login credentials were incorrect, please try again", font: .systemFont(ofSize: 14), textColor: .red, textAlignment: .center, numberOfLines: 0)
    
    lazy var goToRegisterButton = UIButton(title: "Need an account? Go to register.", titleColor: .black, font: .systemFont(ofSize: 17), target: self, action: #selector(goToRegister))
    
    
    @objc func handleLogin() {
    }
    
    @objc func goToRegister() {
        
    }
}
