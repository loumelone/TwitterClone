//
//  ExploreController.swift
//  TwitterClone
//
//  Created by Louis Melone on 4/28/22.
//

import Foundation
import UIKit

class ExploreController: UIViewController {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

    }
    
    // MARK: - helpers
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Explore"
    }
    
}
