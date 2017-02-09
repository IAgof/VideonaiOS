//
//  AddShareTitleTextConstants.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 9/2/17.
//  Copyright © 2017 Videona. All rights reserved.
//

import Foundation

struct AddShareTitleTextConstants{
    static var ADD_YOUTUBE_TITLE:String{
        return getStringByKey("add_youtube_title")
    }
    
    static var ADD_YOUTUBE_MESSAGE:String{
        return getStringByKey("add_youtube_message")
    }

    static var ADD_TWITTER_TITLE:String{
        return getStringByKey("add_twitter_title")
    }
    
    static var ADD_TWITTER_MESSAGE:String{
        return getStringByKey("add_twitter_message")
    }

    static var SAVE:String{
        return getStringByKey("save")
    }
    
    static var CANCEL:String{
        return getStringByKey("cancel")
    }
    private static func getStringByKey(_ key:String) -> String {
        return NSBundle.mainBundle().localizedStringForKey(key, value: "", table: "AddShareTitle")
    }
}
