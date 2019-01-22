//
//  CameraController.swift
//  instagram
//
//  Created by Daniel Dramond on 17/01/2019.
//  Copyright © 2019 Daniel Dramond. All rights reserved.
//

import UIKit

class CameraController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Camera"
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.view.backgroundColor = UIColor.getHexColor("FEFEFE")
        
        setupViews()
    }
    
    func setupViews() {
        
    }
}
