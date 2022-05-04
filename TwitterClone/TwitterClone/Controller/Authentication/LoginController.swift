//
//  LoginController.swift
//  TwitterClone
//
//  Created by Louis Melone on 5/2/22.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "TwitterLogo" )
        return iv
    }()
    
    //Abstract these container views
    
    private lazy var emailContainterView: UIView = {
        let view = Utilities().inputContainerView(
            withImage: UIImage(named: "ic_mail_outline_white_2x-1")!, textField: emailTextField)
        return view
    }()
    
    private lazy var passWordContainerView: UIView = {
        let view = Utilities().inputContainerView(
            withImage: UIImage(named: "ic_lock_outline_white_2x")!, textField: passwordTextField)
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().formatTextField(withPlaceholder: "Email")
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().formatTextField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailContainterView, passWordContainerView])
        stack.axis = .vertical
        stack.spacing = 8
        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 16, paddingRight: 16)
    }
}
