//
//  ViewController+Handlers.swift
//  instagram
//
//  Created by Daniel Dramond on 17/01/2019.
//  Copyright © 2019 Daniel Dramond. All rights reserved.
//

import UIKit

extension ViewController: PostCellDelegate {
    
    @objc func addCustomView() {
        
        self.customView.setupCustomView(view: self.view) { [weak self] in
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self?.removeCustomView(_:)))
            self?.customView.windowView.addGestureRecognizer(gesture)
            self?.customView.showCustomView(view: self!.view)
        }
    }
    
    @objc func removeCustomView(_ sender: UITapGestureRecognizer) {
        self.customView.hideCustomView(view: self.view) { [weak self] in
            self?.customView.removeFromSuperview()
        }
    }
    
    func goToCommentsController(_ post: Post) {
        
        let commentsController = CommentsController()
        commentsController.post = post
        commentsController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(commentsController, animated: true)
    }
    
    func handleGetData() {
        
        let firstUser = User(username: "danny.dramond",
                             profile_image_url: "https://scontent-lhr3-1.cdninstagram.com/vp/038a8f7e6bbdd71370c5260a0429b215/5CFCF285/t51.2885-19/s320x320/18443127_1665255770181674_9152576364337954816_a.jpg?_nc_ht=scontent-lhr3-1.cdninstagram.com")
        
        let firstCommentUser = User(username: "pycoders",
                                    profile_image_url: "https://scontent-lhr3-1.cdninstagram.com/vp/41c86be5bb58f588f5a5b57aa851661c/5CC6F14A/t51.2885-19/s320x320/30841402_1706980969382484_3227704632029478912_n.jpg?_nc_ht=scontent-lhr3-1.cdninstagram.com")
        let firstComment = Comment(user: firstCommentUser,
                                   comment: "Cute dog. Fancy grabbing a coffee some time?",
                                   timestamp: 1548182962)
        
        let secondCommentUser = User(username: "javascript.js",
                                    profile_image_url: "https://scontent-lhr3-1.cdninstagram.com/vp/639ab3db8dfaa9d644d8d1eefab5741d/5CFF6360/t51.2885-19/s150x150/1173232_1184072051607566_422931829_a.jpg?_nc_ht=scontent-lhr3-1.cdninstagram.com")
        let secondComment = Comment(user: secondCommentUser,
                                    comment: "We have a cockapoo too!",
                                    timestamp: 1547731000)
        
        let firstPost = Post(user: firstUser,
                             post_image_url: "https://scontent-lhr3-1.cdninstagram.com/vp/35f201a234112b27c7be9d10a95951d2/5D010739/t51.2885-15/e35/33020090_210418456270106_1698827189551628288_n.jpg?_nc_ht=scontent-lhr3-1.cdninstagram.com",
                             likes: 1660325,
                             text: "This is my puppy, Finn. ",
                             timestamp: 1547731000,
                             liked: false,
                             comments: [firstComment, secondComment])
        
        let secondUser = User(username: "danny.dramond",
                              profile_image_url: "https://scontent-lhr3-1.cdninstagram.com/vp/038a8f7e6bbdd71370c5260a0429b215/5CFCF285/t51.2885-19/s320x320/18443127_1665255770181674_9152576364337954816_a.jpg?_nc_ht=scontent-lhr3-1.cdninstagram.com")
        let secondPost = Post(user: secondUser,
                              post_image_url: "https://scontent-lhr3-1.cdninstagram.com/vp/55224569e5209d58da83eb45afccbbf5/5CFEF9FC/t51.2885-15/e35/33400666_240674716482705_8168534047551651840_n.jpg?_nc_ht=scontent-lhr3-1.cdninstagram.com",
                              likes: 1456580,
                              text: "This is also Finn...",
                              timestamp: 1547732063,
                              liked: false,
                              comments: [])
        
        self.posts = [firstPost, secondPost]
        
        let firstStory = Story(username: "danny.dramond",
                               profile_image_url: "https://scontent-lhr3-1.cdninstagram.com/vp/038a8f7e6bbdd71370c5260a0429b215/5CFCF285/t51.2885-19/s320x320/18443127_1665255770181674_9152576364337954816_a.jpg?_nc_ht=scontent-lhr3-1.cdninstagram.com")
        
        let secondStory = Story(username: "javascript.js",
                                profile_image_url: "https://scontent-lhr3-1.cdninstagram.com/vp/639ab3db8dfaa9d644d8d1eefab5741d/5CFF6360/t51.2885-19/s150x150/1173232_1184072051607566_422931829_a.jpg?_nc_ht=scontent-lhr3-1.cdninstagram.com")
        
        let thirdStory = Story(username: "python.learning",
                               profile_image_url: "https://scontent-lhr3-1.cdninstagram.com/vp/abdfa965646200f7cbd9f3280443c7d8/5CC5A3C2/t51.2885-19/s320x320/43678606_264196787604530_3016770657749827584_n.jpg?_nc_ht=scontent-lhr3-1.cdninstagram.com")
        
        let fourthStory = Story(username: "iosdevlife",
                                profile_image_url: "https://scontent-lhr3-1.cdninstagram.com/vp/4d717069ad3cf4a67ee49d22312b49ed/5CC528CD/t51.2885-19/s320x320/41532986_1973233142755545_3911848173018021888_n.jpg?_nc_ht=scontent-lhr3-1.cdninstagram.com")
        
        self.stories = [firstStory, secondStory, thirdStory, fourthStory]
        
        self.collectionView.reloadData()
    }
    
    func handleEstimatedFrame(_ text: String, font: UIFont) -> CGRect {
        let size = CGSize(width: (self.collectionView.frame.width) - 16, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [kCTFontAttributeName as NSAttributedString.Key: font], context: nil)
    }
    
    func setupNavigationBar() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "camera")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.handleCamera(_:)))
        
        let directMessageButton = UIBarButtonItem(image: UIImage(named: "dm")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.handleDirectMessage(_:)))
        let tvButton = UIBarButtonItem(image: UIImage(named: "tv")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.handleTV(_:)))
        
        self.navigationItem.rightBarButtonItems = [directMessageButton, tvButton]
        
        let logo = UIImage(named: "insta")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
    }
    
    @objc func handleCamera(_ sender: UIBarButtonItem) {
        print("Camera")
    }
    
    @objc func handleTV(_ sender: UIBarButtonItem) {
        print("TV")
    }
    
    @objc func handleDirectMessage(_ sender: UIBarButtonItem) {
        print("Direct Message")
        self.addCustomView()
    }
}
