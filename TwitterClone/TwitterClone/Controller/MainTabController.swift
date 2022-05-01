//
//  MainTabController.swift
//  TwitterClone
//
//  Created by Louis Melone on 4/28/22.
//

import UIKit

class MainTabController: UITabBarController {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewControllers()

    }
    
    // MARK: - helpers
    
    func configureViewControllers() {
        
        let feed = FeedController()
        feed.tabBarItem.image = UIImage(named: "home_unselected")
        
        let explore = ExploreController()
        explore.tabBarItem.image = UIImage(named: "search_unselected")
        
        let notifications = NotificationsController()
        notifications.tabBarItem.image = UIImage(named: "search_unselected")

        let conversations = ConversationsController()
        conversations.tabBarItem.image = UIImage(named: "search_unselected")

        
        //Configures controllers for the main tab
        viewControllers = [feed, explore, notifications, conversations]
    }
    


}
