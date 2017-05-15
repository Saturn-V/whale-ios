//
//  Answer.swift
//  whale-ios-AlexPena
//
//  Created by Alex Aaron Peña on 4/5/17.
//  Copyright © 2017 Alex Aaron Peña. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Answer: Initializable {
    
    let id: Int
    let question: Question
    let videoURL: URL
    let thumbnailURL: URL
    let likesCount: Int?
    let commentCount: Int?
    
    init?(json: JSON) {
        guard let id: Int = json["id"].int,
        let question: Question = Question.init(json: json["question"]),
        let videoURL: URL = json["video_url"].url,
        let thumbnailURL: URL = json["thumbnail_url"].url
            else { return nil }
        
        self.id = id
        self.question = question
        self.videoURL = videoURL
        self.thumbnailURL = thumbnailURL
        self.likesCount = json["likes_count"].int
        self.commentCount = json["comment_count"].int
    }
}
