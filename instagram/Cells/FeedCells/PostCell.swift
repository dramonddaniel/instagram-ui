//
//  PostCell.swift
//  instagram
//
//  Created by Daniel Dramond on 17/01/2019.
//  Copyright © 2019 Daniel Dramond. All rights reserved.
//

import UIKit

class PostCell: BaseCell {
    
    var delegate: PostCellDelegate? = nil
    
    var post: Post? {
        didSet {
            
            guard let username = post?.user?.username, let profile_image_url = post?.user?.profile_image_url, let post_image_url = post?.post_image_url, let numberOfLikes = post?.likes, let text = post?.text, let liked = post?.liked, let comments = post?.comments else { return }
            
            if numberOfLikes > 0 {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = NumberFormatter.Style.decimal
                guard let formattedNumber = numberFormatter.string(from: NSNumber(value: numberOfLikes)) else { return }
                
                self.likesLabel.text = "\(formattedNumber) likes"
                
                self.likesHeightContraint?.constant = 22
                
            } else {
                
                self.likesHeightContraint?.constant = 0
            }
            
            if comments.count > 0 {
                
                if comments.count == 1 {
                    self.addCommentLabelLabel.text = "View comment"
                } else {
                    self.addCommentLabelLabel.text = "View all \(comments.count) comments"
                }
                
                self.addCommentButtonHeightContraint?.constant = 22
                
            } else {
                
                self.addCommentButtonHeightContraint?.constant = 0
            }
            
            self.usernameLabel.text = username.lowercased()
            self.profileImageView.loadImageUsingCacheWithUrlString(profile_image_url)
            self.postImageView.loadImageUsingCacheWithUrlString(post_image_url)
            
            let usernameString = NSAttributedString(string: "\(username) ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 12)!])
            let detailsString = NSAttributedString(string: "\(text)", attributes: [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 12)!])
            
            let newStr = usernameString.mutableCopy() as! NSMutableAttributedString
            newStr.append(detailsString)
            
            self.textView.attributedText = newStr
            
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
            gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: 36, height: 36)
            self.gradientView.layer.insertSublayer(gradientLayer, at: 0)
            
            var image: UIImage? = nil
            if (liked) {
                self.post?.liked = false
                image = UIImage(named: "like_fill")?.withRenderingMode(.alwaysOriginal)
            } else {
                self.post?.liked = true
                image = UIImage(named: "like")?.withRenderingMode(.alwaysOriginal)
            }
            
            self.likeButton.setImage(image, for: .normal)
        }
    }
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.getHexColor("FEFEFE")
        return view
    }()
    
    let menuButton: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal)
        btn.setImage(image, for: .normal)
        return btn
    }()
    
    lazy var gradientView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .red
        view.layer.cornerRadius = 17
        return view
    }()
    
    lazy var profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .black
        iv.layer.cornerRadius = 16
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.white.cgColor
        return iv
    }()
    
    lazy var postImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = UIColor(white: 0.92, alpha: 1.0)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture(_:)))
        gesture.numberOfTapsRequired = 2
        iv.addGestureRecognizer(gesture)
        return iv
    }()
    
    let likeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        let image = UIImage(named: "large_heart")?.withRenderingMode(.alwaysTemplate)
        iv.image = image
        iv.tintColor = UIColor.getHexColor("db565b")
        iv.alpha = 0.0
        iv.layer.shadowColor = UIColor(white: 0.25, alpha: 1.0).cgColor
        iv.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        iv.layer.shadowRadius = 10.0
        iv.layer.shadowOpacity = 0.68
        return iv
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 0.20, alpha: 1.0)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
        return label
    }()
    
    let actionsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.getHexColor("FEFEFE")
        return view
    }()
    
    lazy var likeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(self.likePost), for: .touchUpInside)
        return btn
    }()
    
    let commentButton: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "comment")?.withRenderingMode(.alwaysOriginal)
        btn.setImage(image, for: .normal)
        return btn
    }()
    
    let dmButton: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "post_dm")?.withRenderingMode(.alwaysOriginal)
        btn.setImage(image, for: .normal)
        return btn
    }()
    
    let postDetailsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.getHexColor("FEFEFE")
        return view
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 0.20, alpha: 1.0)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
        label.backgroundColor = .clear
        return label
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.textColor = UIColor(white: 0.20, alpha: 1.0)
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.backgroundColor = .clear
        tv.contentInset = UIEdgeInsets(top: -4, left: -1, bottom: 0, right: 1)
        return tv
    }()
    
    lazy var addCommentLabelLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 0.65, alpha: 1.0)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
        label.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(commentsTapped(_:)))
        label.addGestureRecognizer(gesture)
        return label
    }()
    
    var likesHeightContraint: NSLayoutConstraint? = nil
    var addCommentButtonHeightContraint: NSLayoutConstraint? = nil
    
    override func setupViews() {
        
        self.addSubview(topView)
        _ = topView.anchor(self.topAnchor, self.rightAnchor, nil, self.leftAnchor, 0, 0, 0, 0, width: 0, height: 50)
        
        self.topView.addSubview(profileImageView)
        _ = profileImageView.anchor(nil, nil, nil, topView.leftAnchor, 0, 0, 0, 6, width: 32, height: 32)
        self.profileImageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        
        self.topView.insertSubview(gradientView, belowSubview: profileImageView)
        _ = gradientView.anchor(nil, nil, nil, nil, 0, 0, 0, 0, width: 34, height: 34)
        self.gradientView.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
        self.gradientView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        
        self.topView.addSubview(usernameLabel)
        _ = usernameLabel.anchor(nil, nil, nil, profileImageView.rightAnchor, 0, 0, 0, 6, width: 0, height: 0)
        self.usernameLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        
        self.topView.addSubview(menuButton)
        _ = menuButton.anchor(nil, topView.rightAnchor, nil, nil, 0, 12, 0, 0, width: 30, height: 30)
        menuButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        
        self.addSubview(postImageView)
        let height: CGFloat = self.frame.width / (4 / 5)
        _ = postImageView.anchor(topView.bottomAnchor, self.rightAnchor, nil, self.leftAnchor, 0, 0, 0, 0, width: 0, height: height)
        
        postImageView.addSubview(likeImageView)
        _ = likeImageView.anchor(nil, nil, nil, nil, 0, 0, 0, 0, width: 125, height: 125)
        self.likeImageView.centerXAnchor.constraint(equalTo: postImageView.centerXAnchor).isActive = true
        self.likeImageView.centerYAnchor.constraint(equalTo: postImageView.centerYAnchor).isActive = true
        
        self.addSubview(actionsView)
        _ = actionsView.anchor(postImageView.bottomAnchor, self.rightAnchor, nil, self.leftAnchor, 0, 0, 0, 0, width: 0, height: 44)
        
        self.actionsView.addSubview(likeButton)
        _ = likeButton.anchor(nil, nil, nil, actionsView.leftAnchor, 0, 0, 0, 8, width: 34, height: 30)
        self.likeButton.centerYAnchor.constraint(equalTo: actionsView.centerYAnchor, constant: 0).isActive = true
        
        self.actionsView.addSubview(commentButton)
        _ = commentButton.anchor(nil, nil, nil, likeButton.rightAnchor, 0, 0, 0, 6, width: 34, height: 30)
        self.commentButton.centerYAnchor.constraint(equalTo: actionsView.centerYAnchor, constant: 0).isActive = true
        
        self.actionsView.addSubview(dmButton)
        _ = dmButton.anchor(nil, nil, nil, commentButton.rightAnchor, 0, 0, 0, 6, width: 34, height: 30)
        self.dmButton.centerYAnchor.constraint(equalTo: actionsView.centerYAnchor, constant: 0).isActive = true
        
        self.addSubview(postDetailsView)
        _ = postDetailsView.anchor(actionsView.bottomAnchor, self.rightAnchor, nil, self.leftAnchor, 0, 0, 0, 0, width: 0, height: 0)
        
        self.postDetailsView.addSubview(likesLabel)
        _ = likesLabel.anchor(postDetailsView.topAnchor, postDetailsView.rightAnchor, nil, postDetailsView.leftAnchor, 0, 12, 0, 12, width: 0, height: 0)
        
        self.likesHeightContraint = likesLabel.heightAnchor.constraint(equalToConstant: 0)
        self.likesHeightContraint?.isActive = true
        
        self.postDetailsView.addSubview(textView)
        _ = textView.anchor(likesLabel.bottomAnchor, postDetailsView.rightAnchor, postDetailsView.bottomAnchor, postDetailsView.leftAnchor, 0, 8, 0, 8, width: 0, height: 0)
        
        self.addSubview(addCommentLabelLabel)
        _ = addCommentLabelLabel.anchor(postDetailsView.bottomAnchor, nil, nil, self.leftAnchor, -6, 0, 0, 12, width: 0, height: 0)
        self.addCommentButtonHeightContraint = self.addCommentLabelLabel.heightAnchor.constraint(equalToConstant: 0)
        self.addCommentButtonHeightContraint?.isActive = true
    }
}
