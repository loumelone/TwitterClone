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
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't Have an Account?", " Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK: - Selectors
    
    @objc func handleLogin(){
        print("handle login here")
    }
    
    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        
        loginButton.anchor(height: 50)
        let stack = UIStackView(arrangedSubviews: [emailContainterView, passWordContainerView, loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
        
    }
}
