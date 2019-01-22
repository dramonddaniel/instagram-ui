//
//  CommentCell.swift
//  instagram
//
//  Created by Daniel Dramond on 20/01/2019.
//  Copyright © 2019 Daniel Dramond. All rights reserved.
//

import UIKit

class CommentCell: BaseCell {
    
    var comment: Comment? {
        didSet {
            
            guard let url = self.comment?.user?.profile_image_url, let username = self.comment?.user?.username, let text = self.comment?.comment else { return }
            self.profileImageView.loadImageUsingCacheWithUrlString(url)
            
            if let seconds = comment?.timestamp?.doubleValue {
                let timestampDate = Date(timeIntervalSince1970: seconds)
                self.timeLabel.text = timestampDate.timeAgoDisplay()
            }
            
            let usernameString = NSAttributedString(string: "\(username) ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 12) ?? .boldSystemFont(ofSize: 12)])
            let detailsString = NSAttributedString(string: "\(text)", attributes: [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 12) ?? .boldSystemFont(ofSize: 12)])
            
            let newStr = usernameString.mutableCopy() as! NSMutableAttributedString
            newStr.append(detailsString)
            
            self.textView.attributedText = newStr
        }
    }
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = UIColor(white: 0.20, alpha: 1.0)
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 17
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.textColor = UIColor(white: 0.20, alpha: 1.0)
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.backgroundColor = .clear
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tv.clipsToBounds = true
        return tv
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 0.20, alpha: 1.0)
        label.font = UIFont(name: "HelveticaNeue", size: 10)
        return label
    }()
    
    let replyLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 0.50, alpha: 1.0)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 10)
        label.text = "Reply"
        return label
    }()
    
    override func setupViews() {
        
        self.backgroundColor = .clear
        
        self.addSubview(profileImageView)
        _ = profileImageView.anchor(self.topAnchor, nil, nil, self.leftAnchor, 10, 0, 0, 10, width: 34, height: 34)
        
        self.addSubview(textView)
        _ = textView.anchor(self.topAnchor, self.rightAnchor, nil, profileImageView.rightAnchor, 2, 10, 0, 10, width: 0, height: 0)
        
        self.addSubview(bottomView)
        _ = bottomView.anchor(textView.bottomAnchor, self.rightAnchor, nil, profileImageView.rightAnchor, 0, 10, 0, 15, width: 0, height: 22)
        
        self.bottomView.addSubview(timeLabel)
        _ = timeLabel.anchor(bottomView.topAnchor, nil, bottomView.bottomAnchor, bottomView.leftAnchor, 0, 0, 0, 0, width: 30, height: 0)
        
        self.bottomView.addSubview(replyLabel)
        _ = replyLabel.anchor(bottomView.topAnchor, nil, bottomView.bottomAnchor, timeLabel.rightAnchor, 0, 0, 0, 0, width: 30, height: 0)
    }
}
