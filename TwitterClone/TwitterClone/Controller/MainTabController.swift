//
//  MainTabController.swift
//  TwitterClone
//
//  Created by Louis Melone on 4/28/22.
//

import UIKit

class MainTabController: UITabBarController {
    // MARK: - Properties
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        configureUI()
        tabBar.backgroundColor = .systemGray6
        
    }
    
    // MARK: - Selectors
    
    @objc func actionButtonTapped(){
        
    }
    
    // MARK: - helpers
    
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
    }
    
    func configureViewControllers() {
        
        let feed = templateNavigationController(image: "home_unselected", rootViewController: FeedController())
        
        let explore = templateNavigationController(image: "search_unselected", rootViewController: ExploreController())
        
        let notifications = templateNavigationController(image: "like_unselected", rootViewController: NotificationsController())

        let conversations = templateNavigationController(image: "ic_mail_outline_white_2x-1", rootViewController: ConversationsController())

        //Configures controllers for the main tab
        viewControllers = [feed, explore, notifications, conversations]
    }
    
    func templateNavigationController(image: String, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = UIImage(named: image)
        return nav
    }

}
