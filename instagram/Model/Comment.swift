//
//  Comment.swift
//  instagram
//
//  Created by Daniel Dramond on 19/01/2019.
//  Copyright © 2019 Daniel Dramond. All rights reserved.
//

import Foundation

class Comment: NSObject {
    
    var user: User? = nil
    var comment: String? = nil
    var timestamp: NSNumber? = nil
    
    init(user: User?, comment: String?, timestamp: NSNumber?) {
        self.user = user
        self.comment = comment
        self.timestamp = timestamp
    }
}
