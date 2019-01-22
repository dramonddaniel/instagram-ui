//
//  Post.swift
//  instagram
//
//  Created by Daniel Dramond on 17/01/2019.
//  Copyright © 2019 Daniel Dramond. All rights reserved.
//

import Foundation

class Post: NSObject {
    
    var user: User? = nil
    var post_image_url: String? = nil
    var likes: Int? = nil
    var text: String? = nil
    var timestamp: NSNumber? = nil
    var liked: Bool? = false
    var comments: [Comment]? = nil
    
    init(user: User?, post_image_url: String?, likes: Int?, text: String?, timestamp: NSNumber?, liked: Bool?, comments: [Comment]?) {
        
        self.user = user
        self.post_image_url = post_image_url
        self.likes = likes
        self.text = text
        self.timestamp = timestamp
        self.liked = liked
        self.comments = comments
    }
}

class User: NSObject {
    
    var username: String? = nil
    var profile_image_url: String? = nil
    
    init(username: String?, profile_image_url: String?) {
        self.username = username
        self.profile_image_url = profile_image_url
    }
}
