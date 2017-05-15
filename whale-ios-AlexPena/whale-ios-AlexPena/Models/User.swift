//
//  User.swift
//  whale-ios-AlexPena
//
//  Created by Alex Aaron Peña on 3/20/17.
//  Copyright © 2017 Alex Aaron Peña. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    var id: Int
    var username: String
    var email: String
    var firstName: String
    var lastName: String
    var imageURL: URL?
    var followingCount: Int?
    var followerCount: Int?
    
    init?(json: JSON) {
        guard let id: Int = json["id"].int,
        let username: String = json["username"].string,
        let email: String = json["email"].string,
        let firstName: String = json["first_name"].string,
        let lastName: String = json["last_name"].string
            else { return nil }
            
        self.id = id
        self.username = username
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.imageURL = json["image_url"].url
        self.followingCount = json["following_count"].int ?? 0
        self.followerCount = json["follower_count"].int ?? 0
    }
}

