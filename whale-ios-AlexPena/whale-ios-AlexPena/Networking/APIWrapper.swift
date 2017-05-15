//
//  APIWrapper.swift
//  whale-ios-AlexPena
//
//  Created by Alex Aaron Peña on 3/20/17.
//  Copyright © 2017 Alex Aaron Peña. All rights reserved.
//

import Alamofire
import AlamofireImage
import SwiftyJSON
import UIKit

class APIWrapper {
    
    class func isAuthenticated(status: Int) throws {
        if status == 401 {
            throw NetworkError.unauthorizedError
        }
//        return Result.success(data: true)
    }
    
    class func login() {
        let parameters = [
            "email": "gordoneliel@gmail.com",
            "password": "example"
        ]
        
        Alamofire.request("https://whale2-elixir.herokuapp.com/api/v1/sessions", method: .post, parameters: parameters, encoding: JSONEncoding.default) .responseJSON { response in
            if let data = response.data, let token = response.response {
                let userJson = JSON(data: data)
                let authToken = token.allHeaderFields["Authorization"] as! String
                
                KeychainWrapper.storeAuthToken(token: authToken)
            }
        }
    }
    
    class func getAnswers(perPage: Int, page: Int, callback: @escaping (_ pageAnswers: Result<Page<Answer>>) -> Void) {
        let parameters = [
            "per_page": perPage,
            "page": page
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": KeychainWrapper.getValue(key: "auth_token"),
            "Accept": "application/json"
        ]
        
        Alamofire.request("https://whale2-elixir.herokuapp.com/api/v1/answers", parameters: parameters, headers: headers).responseJSON { response in
            
            let statusCode = (response.response?.statusCode)!
            
            do {
                try isAuthenticated(status: statusCode)
                if let data = response.data {
                    let json = JSON(data: data)
                    let page = Page<Answer>(json: json)
                    callback(Result<Page<Answer>>.success(data: page!))
                }
            } catch {
                if statusCode == 401 {
                    callback(Result<Page<Answer>>.failure(reason: NetworkError.unauthorizedError))
                } else {
                    callback(Result<Page<Answer>>.failure(reason: NetworkError.responseError))
                }
            }
        }
    }
    
    class func getComments(answerId: Int, perPage: Int, page: Int, callback: @escaping (_ pageComments: Page<Comment>) -> Void) {
        let parameters = [
            "per_page": perPage,
            "page": page
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": KeychainWrapper.getValue(key: "auth_token"),
            "Accept": "application/json"
        ]
        
        Alamofire.request("https://whale2-elixir.herokuapp.com/api/v1/answers/\(answerId)/comments", parameters: parameters, headers: headers).responseJSON { response in
            if let data = response.data {
                let json = JSON(data: data)
                let page = Page<Comment>(json: json)
                callback(page!)
            }
        }
        
    }
    
    class func getQuestions(perPage: Int, page: Int, callback: @escaping (_ pageQuestions: Page<Question>) -> Void) {
        let parameters = [
            "per_page": perPage,
            "page": page
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": KeychainWrapper.getValue(key: "auth_token"),
            "Accept": "application/json"
        ]
        
        Alamofire.request("https://whale2-elixir.herokuapp.com/api/v1/questions", parameters: parameters, headers: headers).responseJSON { response in
            if let data = response.data {
                let json = JSON(data: data)
                let page = Page<Question>(json: json)
                callback(page!)
            }
        }
    }
}


enum Result<T> {
    case success(data: T)
    case failure(reason: NetworkError)
}

enum NetworkError: Error {
    case responseError
    case unauthorizedError
}

