//
//  ShareInstagramInteractor.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 6/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import Photos

class ShareInstagramInteractor:ShareSocialNetworkInteractor{
   
    func share(){
        //Get last videoAsset on PhotoLibrary
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending:false)]
        let fetchResult = PHAsset.fetchAssetsWithMediaType(.Video, options: fetchOptions)
        if let lastAsset = fetchResult.firstObject as? PHAsset {
            //Share to instagram
            let instagramURL = NSURL.init(string: "instagram://library?LocalIdentifier=\(lastAsset.localIdentifier)")!
            if UIApplication.sharedApplication().canOpenURL(instagramURL) {
                UIApplication.sharedApplication().openURL(instagramURL)
            }
        }
    }
}