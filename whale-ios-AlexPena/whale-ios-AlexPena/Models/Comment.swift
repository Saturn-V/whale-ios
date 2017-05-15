//
//  Comment.swift
//  whale-ios-AlexPena
//
//  Created by Alex Aaron Peña on 4/5/17.
//  Copyright © 2017 Alex Aaron Peña. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Comment: Initializable {
    let id: Int
    let content: String
    let commenter: User
    let answer_id: Int
    
    init?(json: JSON) {
        guard let id: Int = json["id"].int,
            let content: String = json["content"].string,
            let commenter: User = User.init(json: json["commenter"]),
            let answer_id: Int = json["answer_id"].int
            else { return nil }
        
        self.id = id
        self.content = content
        self.commenter = commenter
        self.answer_id = answer_id
    }
}
