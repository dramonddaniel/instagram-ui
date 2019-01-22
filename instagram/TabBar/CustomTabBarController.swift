//
//  CustomTabBarController.swift
//  instagram
//
//  Created by Daniel Dramond on 17/01/2019.
//  Copyright © 2019 Daniel Dramond. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeController = ViewController()
        let navigationHomeController = UINavigationController(rootViewController: homeController)
        navigationHomeController.tabBarItem.tag = 0
        navigationHomeController.tabBarItem.image = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        navigationHomeController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        
        let searchController = SearchController()
        let navigationSearchController = UINavigationController(rootViewController: searchController)
        navigationSearchController.tabBarItem.tag = 0
        navigationSearchController.tabBarItem.image = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        navigationSearchController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        
        let cameraController = CameraController()
        let navigationCameraController = UINavigationController(rootViewController: cameraController)
        navigationCameraController.tabBarItem.tag = 0
        navigationCameraController.tabBarItem.image = UIImage(named: "add")?.withRenderingMode(.alwaysOriginal)
        navigationCameraController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        
        let activityController = ActivityController()
        let navigationActivityController = UINavigationController(rootViewController: activityController)
        navigationActivityController.tabBarItem.tag = 0
        navigationActivityController.tabBarItem.image = UIImage(named: "heart")?.withRenderingMode(.alwaysOriginal)
        navigationActivityController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        
        let profileController = ProfileController()
        let navigationProfileController = UINavigationController(rootViewController: profileController)
        navigationProfileController.tabBarItem.tag = 0
        navigationProfileController.tabBarItem.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
        navigationProfileController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        
        viewControllers = [navigationHomeController, navigationSearchController, navigationCameraController, navigationActivityController, navigationProfileController]
        
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = UIColor.getHexColor("FEFEFE")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.navigationBar.barTintColor = .white
    }
}
