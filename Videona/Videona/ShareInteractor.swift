//
//  ShareInteractor.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 13/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class ShareInteractor: NSObject {
    
    func findSocialNetworks()->(socialNetworkTitleArray:Array<String>, socialNetworkImageArray:Array<UIImage>){
        let socialNetworks = SocialNetworkProvider().getSocialNetworks()
        
        let socialNetworkImage = self.setArraySocialNetworksUIImage(socialNetworks)
        let socialNetworkTitle = self.setArraySocialNetworksTitle(socialNetworks)
        
        return (socialNetworkTitle,socialNetworkImage)
    }
    
    func setArraySocialNetworksTitle(sNArray:Array<SocialNetwork>)->Array<String>{
        var titleArray = Array<String>()
        
        for title in sNArray{
            titleArray.append(title.getTitle())
        }
        return titleArray
    }
    
    func setArraySocialNetworksUIImage(sNArray:Array<SocialNetwork>)->Array<UIImage>{
        var imageArray = Array<UIImage>()
        
        for imageName in sNArray{
            let image = UIImage.init(named: imageName.getIconId())
            imageArray.append(image!)
        }
        
        return imageArray
    }
    
}