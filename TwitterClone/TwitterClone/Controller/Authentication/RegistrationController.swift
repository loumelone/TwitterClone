//
//  RegistrationController.swift
//  TwitterClone
//
//  Created by Louis Melone on 5/2/22.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account?", " Log In")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
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
    
    private lazy var fullNameContainterView: UIView = {
        let view = Utilities().inputContainerView(
            withImage: UIImage(named: "ic_person_outline_white_2x")!, textField: fullNameTextField)
        return view
    }()
    
    private lazy var userNameContainerView: UIView = {
        let view = Utilities().inputContainerView(
            withImage: UIImage(named: "ic_person_outline_white_2x")!, textField: userNameTextField)
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
    
    private let fullNameTextField: UITextField = {
        let tf = Utilities().formatTextField(withPlaceholder: "Full Name")
        return tf
    }()
    
    private let userNameTextField: UITextField = {
        let tf = Utilities().formatTextField(withPlaceholder: "Username")
        return tf
    }()

    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSignUp() {
        guard let profileImage = profileImage else {
            print("DEBUG: Please select a profile image")
            return
        }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullName = fullNameTextField.text else { return }
        guard let userName = userNameTextField.text else { return }
        
        let credentials = AuthCredentials(email: email, password: password, fullName: fullName, userName: userName, profileImage: profileImage)
        
        AuthService.shared.registerUser(credentials: credentials) { (error, ref) in
            print("DEBUG: Sign Up successfull..")
            print("DEBUG: Handle update user interface here...")
        }
        
    }
    
    @objc func handleAddProfilePhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        plusPhotoButton.setDimensions(width: 150, height: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailContainterView, passWordContainerView, fullNameContainterView, userNameContainerView, signUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
    }
    
}

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        
        plusPhotoButton.layer.cornerRadius = 128/2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFit
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
        
    }
}
