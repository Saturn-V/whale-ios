//
//  Page.swift
//  whale-ios-AlexPena
//
//  Created by Alex Aaron Peña on 4/5/17.
//  Copyright © 2017 Alex Aaron Peña. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Initializable {
    init?(json: JSON)
}

class Page<T: Initializable> {
//    UPDATE TO WORK WITH COMMENTS AS WELL
    
    var totalPages: Int
    var perPage: Int
    var currentPage: Int
    var data: [T]
    
    init?(json: JSON) {
        
        guard let totalPages: Int = json["total_pages"].int,
        let perPage: Int = json["total_pages"].int,
        let currentPage: Int = json["page"].int,
        let data: [JSON] = json["data"].array
            else { return nil }
        
        self.totalPages = totalPages
        self.perPage = perPage
        self.currentPage = currentPage
        self.data = data.flatMap(T.init)
    }
}
