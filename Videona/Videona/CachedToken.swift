//
//  CachedToken.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 24/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class CachedToken: NSObject {
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    func hasToken() -> Bool {
        return defaults.boolForKey(LoginConstants.HasTokenSaved)
    }
    
    func getToken() -> Token {
        if let tokenString = defaults.stringForKey(LoginConstants.LoginTokenSaved){
            return Token(token: tokenString)
        }else{
            return Token(token: "")
        }
    }
    
    func setToken(token:Token) {
        defaults.setObject(token.getToken(),
                           forKey: LoginConstants.LoginTokenSaved)
        defaults.setObject(true,
                           forKey: LoginConstants.HasTokenSaved)
        defaults.synchronize()
    }
    
    func deleteToken(){
        defaults.setObject(nil,
                           forKey: LoginConstants.LoginTokenSaved)
        defaults.setObject(false,
                           forKey: LoginConstants.HasTokenSaved)
    }
}