//
//  SocialNetworkProvider.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 13/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class SocialNetworkProvider:NSObject{
    
    func getSocialNetworks() ->Array<SocialNetwork>{
        var socialNetworks = Array<SocialNetwork>()
        
        socialNetworks.append( SocialNetwork(iconId: "activity_record_icon_stop_normal", title: "Facebook"))
        socialNetworks.append( SocialNetwork(iconId: "activity_record_icon_stop_normal", title: "Instagram"))
        socialNetworks.append(SocialNetwork(iconId: "activity_record_icon_stop_normal", title: "Twitter"))
        socialNetworks.append(SocialNetwork(iconId: "activity_record_icon_stop_normal", title: "Gmail"))
        socialNetworks.append(SocialNetwork(iconId: "activity_record_icon_stop_normal", title: "Save to gallery"))

        return socialNetworks
    }
}