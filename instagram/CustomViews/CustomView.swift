//
//  CustomView.swift
//  instagram
//
//  Created by Daniel Dramond on 19/01/2019.
//  Copyright © 2019 Daniel Dramond. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    deinit {
        print("Removing CustomView from memory")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.getHexColor("FEFEFE")
        
        self.layer.cornerRadius = 6
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.12
        
        setupViews()
    }
    
    let windowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.55)
        view.alpha = 0.0
        return view
    }()
    
    let imageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderColor = UIColor.getHexColor("FEFEFE").cgColor
        iv.layer.borderWidth = 5
        iv.layer.cornerRadius = 35
        let url = "https://avatars3.githubusercontent.com/u/19694636?s=400&u=16648eabd3c30f319ca07b0492c7183cb02f6e91&v=4"
        iv.loadImageUsingCacheWithUrlString(url)
        return iv
    }()
    
    let titleText: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue", size: 13)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Email:\ndramonddaniel@gmail.com"
        return label
    }()
    
    func setupViews() {
        
        self.addSubview(imageView)
        _ = imageView.anchor(self.topAnchor, nil, nil, nil, -35, 0, 0, 0, width: 70, height: 70)
        self.imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.addSubview(titleText)
        _ = titleText.anchor(imageView.bottomAnchor, self.rightAnchor, self.bottomAnchor, self.leftAnchor, 0, 20, 6, 20, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomView {
    
    func setupCustomView(view: UIView, _ completion: (() -> Swift.Void)? = nil) {
        
        guard let window = UIApplication.shared.keyWindow else { return }
        
        window.addSubview(windowView)
        windowView.frame = window.bounds
        window.addSubview(self)
        
        _ = self.anchor(nil, nil, nil, nil, 0, 0, 0, 0, width: 220, height: 100)
        self.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
        
        view.layoutIfNeeded()
        
        completion?()
    }
    
    func showCustomView(view: UIView, _ completion: (() -> Swift.Void)? = nil) {
        
        UIView.animate(withDuration: 0.40, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.alpha = 1.0
            self.windowView.alpha = 1.0
        }) { (completed) in completion?() }
    }
    
    func hideCustomView(view: UIView, _ completion: (() -> Swift.Void)? = nil) {
        
        UIView.animate(withDuration: 0.40, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.alpha = 0.0
            self.windowView.alpha = 0.0
        }) { (completed) in self.removeFromSuperview(); completion?() }
    }
}
