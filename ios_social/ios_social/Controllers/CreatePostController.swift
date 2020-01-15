//
//  CreatePostController.swift
//  ios_social
//
//  Created by new on 1/7/20.
//  Copyright © 2020 Ievgen Gavrysh. All rights reserved.
//

import LBTATools
import Alamofire
import JGProgressHUD

class CreatePostController: UIViewController, UITextViewDelegate {
    
    let selectedImage: UIImage
    
    let imageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    
    weak var homeController: HomeController?
    
    let placeholderLabel = UILabel(
        text: "Enter your post body text...",
        font: .systemFont(ofSize: 14),
        textColor: .lightGray)
    
    lazy var postButton = UIButton(
        title: "Post",
        titleColor: .white,
        font: .boldSystemFont(ofSize: 14),
        backgroundColor: UIColor(red: 0.11, green: 0.56, blue: 0.99, alpha: 1),
        target: self,
        action: #selector(handlePost))
    
    let postBodyTextView = UITextView(text: nil, font: .systemFont(ofSize: 14))
    
    init(selectedImage: UIImage) {
        self.selectedImage = selectedImage
        super.init(nibName: nil, bundle: nil)
        imageView.image = selectedImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // here is the layour of our UI
        postButton.layer.cornerRadius = 5
        
        view.stack(
            imageView.withHeight(300),
            view.stack(
                postButton.withHeight(40),
                placeholderLabel,
                spacing: 16).padLeft(16).padRight(16),
            UIView(),
            spacing: 16)
        
        // setup UITextView on top of placeholder label, UITextView does not have a placeholder property
        view.addSubview(postBodyTextView)
        postBodyTextView.backgroundColor = .clear
        postBodyTextView.delegate = self
        postBodyTextView.anchor(
            top: placeholderLabel.bottomAnchor,
            leading: placeholderLabel.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: -25, left: -6, bottom: 0, right: 16))
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.alpha = !textView.text.isEmpty ? 0 : 1
    }
    
    @objc fileprivate func handlePost() {
        // we'll be uploading our image here
        let url = "http://localhost:1337/post"
        
        let hud = JGProgressHUD(style: .dark)
        hud.indicatorView = JGProgressHUDRingIndicatorView()
        hud.textLabel.text = "Uploading"
        hud.show(in: view)
        
        guard let text = postBodyTextView.text else { return }
        
        Alamofire.upload(multipartFormData: { (formData) in
            // post text
            formData.append(Data(text.utf8), withName: "postBody")
            
            // post image
            guard let imagedata = self.selectedImage.jpegData(compressionQuality: 0.5) else { return }
            formData.append(imagedata, withName: "imagefile", fileName: "DoesntMatterSoMatch", mimeType: "iamge/jpg")
        }, to: url) { (res) in
            switch res {
            case .failure(let err):
                print("Failed to hit server: ", err)
            case .success(let uploadRequest, _, _):
                uploadRequest.uploadProgress { (progress) in
                    print("Upload progress: \(progress.fractionCompleted)")
                    DispatchQueue.main.async {
                        hud.setProgress(Float(progress.fractionCompleted), animated: true)
                        hud.textLabel.text = "Uploading\n\(Int(progress.fractionCompleted * 100))% Complete"
                    }
                }
                
                uploadRequest.responseJSON { (dataResp) in
                    if let err = dataResp.error {
                        print("Failed to hit server: ", err)
                        return
                    }
                    
                    if let code = dataResp.response?.statusCode, code >= 300 {
                        print("Failed upload with status: ", code)
                    }
                    
                    print("Successfully created post, here is the response:")
                    
                    self.dismiss(animated: true) {
                        self.homeController?.fetchPosts()
                    }
                }
            }
            print("Maybe finished uploading")
        }
    }
}
