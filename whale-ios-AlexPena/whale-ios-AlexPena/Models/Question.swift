//
//  Question.swift
//  whale-ios-AlexPena
//
//  Created by Alex Aaron Peña on 4/5/17.
//  Copyright © 2017 Alex Aaron Peña. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Question: Initializable {
    let id: Int
    let content: String
    let sender: User
    let receiver: User

    init?(json: JSON) {
        // decode sender and receiver as users
        guard let id: Int = json["id"].int,
        let content: String = json["content"].string,
        let sender: User = User.init(json: json["sender"]),
        let receiver: User = User.init(json: json["receiver"])
            else { return nil }
        
        self.id = id
        self.content = content
        self.sender = sender
        self.receiver = receiver
    }
}
