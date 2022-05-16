//
//  AuthService.swift
//  TwitterClone
//
//  Created by Louis Melone on 5/15/22.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullName: String
    let userName: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference)-> Void) {
        
        let email = credentials.email
        let userName = credentials.userName
        let fullName = credentials.fullName
        
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        
        // 1  Put image in storage
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            // 2 Get URL we just downloaded
            storageRef.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                // 3 Put a user with Firebase Authentication
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                    if let error = error {
                        print("DEBUG: Error is \(error.localizedDescription)")
                        return
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    
                    let values = ["email" : email,
                                  "username":userName,
                                  "fullname": fullName,
                                  "profileImageUrl":profileImageUrl]
                    
                    // 4 Put user information in database using the user id we got back
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                }
            }
        }
    }
}
