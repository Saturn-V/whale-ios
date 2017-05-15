//
//  KeychainWrapper.swift
//  whale-ios-AlexPena
//
//  Created by Alex Aaron Peña on 4/3/17.
//  Copyright © 2017 Alex Aaron Peña. All rights reserved.
//

import Foundation
import KeychainAccess

class KeychainWrapper {
    static var keychain = Keychain()
    
    class func storeAuthToken(token: String) {
        self.keychain["auth_token"] = token
    }
    
    class func userIsAuthenticated() -> Bool {
        var authenticated: Bool = false
        
        do {
            let item = try keychain.get("auth_token")
            
            if item != nil {
                authenticated = true
            }
            
        } catch {
            print(error)
            authenticated = false
        }
        
        return authenticated
    }
    
    class func getValue(key: String) -> String {
        var value: String = ""
        
        do {
            let item = try keychain.get(key)
            
            if item != nil {
                value = item!
            }
            
        } catch {
            print(error)
            value = "Not Found"
        }
        
        return value
    }
}
