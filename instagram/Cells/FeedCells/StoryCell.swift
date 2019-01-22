//
//  StoryCell.swift
//  instagram
//
//  Created by Daniel Dramond on 17/01/2019.
//  Copyright © 2019 Daniel Dramond. All rights reserved.
//

import UIKit

class StoryCell: BaseCell {
    
    var story: Story? {
        didSet {
            
            guard let url = story?.profile_image_url, let username = story?.username else { return }
            self.storyImageView.loadImageUsingCacheWithUrlString(url)
            self.titleLabel.text = username.lowercased()
            
            let first = UIColor.getHexColor("FCAF45").cgColor
            let second = UIColor.getHexColor("F77737").cgColor
            let third = UIColor.getHexColor("C13584").cgColor
            let fourth = UIColor.getHexColor("833AB4").cgColor
            
            let firstArray: [CGColor] = [first, second, third, fourth]
            let secondArray: [CGColor] = [fourth, third, second, first]
            let combined = [firstArray, secondArray]
            let randomIndex = Int(arc4random_uniform(UInt32(combined.count)))
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = combined[randomIndex]
            gradientLayer.locations = [0.25, 0.5, 0.75, 1.0]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.width - 10 - 12, height: self.frame.width - 10 - 12)
            self.gradientView.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    lazy var storyImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = UIColor.getHexColor("FEFEFE")
        iv.layer.cornerRadius = (self.frame.width - 14 - 12) / 2
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.getHexColor("FEFEFE").cgColor
        return iv
    }()
    
    lazy var gradientView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .black
        view.layer.cornerRadius = (self.frame.width - 10 - 12) / 2
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 0.20, alpha: 1.0)
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews() {
        
        self.addSubview(gradientView)
        _ = gradientView.anchor(nil, nil, nil, nil, 0, 0, 0, 0, width: self.frame.width - 10 - 12, height: self.frame.width - 10 - 12)
        self.gradientView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.gradientView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        
        self.addSubview(storyImageView)
        _ = storyImageView.anchor(nil, nil, nil, nil, 0, 0, 0, 0, width: self.frame.width - 14 - 12, height: self.frame.width - 14 - 12)
        self.storyImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.storyImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        
        self.addSubview(titleLabel)
        _ = titleLabel.anchor(gradientView.bottomAnchor, self.rightAnchor, self.bottomAnchor, self.leftAnchor, 0, 6, 0, 6, width: 0, height: 0)
    }
}
