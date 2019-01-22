//
//  Story.swift
//  instagram
//
//  Created by Daniel Dramond on 17/01/2019.
//  Copyright © 2019 Daniel Dramond. All rights reserved.
//

import Foundation

class Story: NSObject {
    
    var username: String? = nil
    var profile_image_url: String? = nil
    
    init(username: String?, profile_image_url: String?) {
        
        self.username = username
        self.profile_image_url = profile_image_url
    }
}
