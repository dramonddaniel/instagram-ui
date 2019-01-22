//
//  CommentsController+Handlers.swift
//  instagram
//
//  Created by Daniel Dramond on 20/01/2019.
//  Copyright © 2019 Daniel Dramond. All rights reserved.
//

import UIKit

extension CommentsController {
    
    func textHeight(_ username: String, _ comment: String) -> CGFloat {
        
        let usernameHeight: CGFloat = username.estimatedFrame(self.collectionView, 10 + 34 + 10 + 10, UIFont(name: "HelveticaNeue-Medium", size: 12) ?? .boldSystemFont(ofSize: 12)).height
        
        let commentHeight: CGFloat = comment.estimatedFrame(self.collectionView, 10 + 34 + 10 + 10, UIFont(name: "HelveticaNeue", size: 12) ?? .boldSystemFont(ofSize: 12)).height
        
        return usernameHeight + commentHeight
    }
    
    @objc func handleBack(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupNavigationBar() {
        
        let backButton = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.handleBack(_:)))
        
        self.navigationItem.leftBarButtonItem = backButton
        
        let directMessageButton = UIBarButtonItem(image: UIImage(named: "dm")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.handleDirectMessage(_:)))
        
        self.navigationItem.rightBarButtonItem = directMessageButton
    }
    
    @objc func handleDirectMessage(_ sender: UIBarButtonItem) {
        print("Direct Message")
    }
}
