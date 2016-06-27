//
//  Token.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class Token:NSObject {
    private var acces_token:String!
    
    init(token:String) {
        self.acces_token = token
    }
    
    func getToken() -> String {
        return acces_token
    }
}