//
//  User.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

/**
 * Class that represents the User in the model layer,
 */
class User {
    var name:String
    var email:String
    var id:Int
    var avatarPath:String
    
    init(name:String) {
        self.name = name
    }
    
    init(name:String,email:String) {
        self.name = name
        self.email = email
    }
    
    init(name:String, email:String, avatarPath:String, id:Int) {
    self.name = name
    self.email = email
    self.avatarPath = avatarPath
    self.id = id
    }
    
    
    func getName() ->String{
        return name
    }
    
    func setName(name:String) {
        self.name = name
    }
    
    func getEmail() ->String {
        return email
    }
    
    func setEmail(email:String) {
        self.email = email
    }
    
    func getId()  ->Int{
        return id
    }
    
    func setId(id:Int) {
        self.id = id
    }
    
    func getAvatarPath() ->String {
        return avatarPath
    }
    
    func setAvatarPath(avatarPath:String) {
        self.avatarPath = avatarPath
    }
    
    
}
