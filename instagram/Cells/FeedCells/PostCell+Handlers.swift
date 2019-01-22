//
//  PostCell+Handlers.swift
//  instagram
//
//  Created by Daniel Dramond on 20/01/2019.
//  Copyright © 2019 Daniel Dramond. All rights reserved.
//

import UIKit

extension PostCell {
    
    @objc func doubleTapGesture(_ sender: UITapGestureRecognizer) {
        
        guard let liked = post?.liked else { return }
        self.likePost()
        if (liked) {
            self.likeAnimation()
        }
    }
    
    @objc func commentsTapped(_ sender: UITapGestureRecognizer) {
        guard let p = self.post else { return }
        self.delegate?.goToCommentsController(p)
    }
    
    func likeAnimation() {
        
        UIView.animate(withDuration: 0.30, delay: 0.20, options: [.curveEaseOut], animations: {
            
            self.likeImageView.alpha = 1.0
            
        }) { (_) in
            
            UIView.animate(withDuration: 0.15, delay: 0.15, options: [.curveEaseOut], animations: {
                
                self.likeImageView.transform = CGAffineTransform(scaleX: 1.18, y: 1.18)
                
            }) { (_) in
                
                UIView.animate(withDuration: 0.15, delay: 0.0, options: [.curveEaseOut], animations: {
                    self.likeImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }) { (_) in
                    
                    UIView.animate(withDuration: 0.30, delay: 0.40, options: [.curveEaseOut], animations: {
                        self.likeImageView.alpha = 0.0
                    }, completion: nil)
                }
            }
            
        }
    }
    
    @objc func likePost() {
        guard let liked = post?.liked else { return }
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
