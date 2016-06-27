//
//  LoginUser.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import Alamofire

class LoginUser: NSObject {
    
    func userIsLoggedIn(completion:(Bool)->Void){
        completion(CachedToken().hasToken())
    }
    
    func login(user:String,
               password:String,
               completion:(String)->Void) {
        
        let parameters: [String: AnyObject] = ["username":user,
                          "password":password]
        let url = "\(ConfigPreferences().VIDEONA_URI_API)\(ConfigPreferences().LOGIN_AUTH)"
        
        
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON).responseJSON(completionHandler: {
        response in
            print(response)
            
            switch response.result {
            case .Success(let JSON):
                print("Success with JSON: \(JSON)")
                
                let response = JSON as! NSDictionary
                
                //example if there is an id
                let token = response.objectForKey("access_token")
                
                if (token != nil) {
                    completion(token as! String)
                }else{
                    completion(ResponseConstants.InvalidCredentials)
                }
                
            case .Failure(let error):
                print("Request failed with error: \(error)")
                completion(ResponseConstants.Error)
            }
        })
    }
}