//
//  ShareTwitterInteractor.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 6/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import Accounts
import Social
import AVFoundation

class ShareTwitterInteractor: ShareSocialNetworkInteractor {
    
    func share(){
        let videoURL = self.getShareMovieURL()
        
        if canUploadVideoToTwitter(videoURL) {
            let accountStore:ACAccountStore = ACAccountStore.init()
            let accountType:ACAccountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
            
            accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (let granted, let error) in
                let accounts = accountStore.accountsWithAccountType(accountType)
                
                if accounts.count > 0 {
                    let twitterAccount = accounts[0]
                    if(SocialVideoHelper.userHasAccessToTwitter()){
                        let videoData = NSData(contentsOfURL: videoURL)
                        SocialVideoHelper.uploadTwitterVideo(videoData,
                                                             comment: Utils().getStringByKeyFromShare(ShareConstants().VIDEONATIME_HASTAGH),
                                                             account: twitterAccount as! ACAccount, withCompletion: {succes,error in
                                                                print("Video upload completion \(succes) \n \(error)")
                                                                var message:String = ""
                                                                
                                                                if (succes) {
                                                                    message = Utils().getStringByKeyFromShare(ShareConstants().UPLOAD_SUCCESFULL)
                                                                }else{
                                                                    message = error
                                                                }
                                                                self.setAlertCompletionMessageOnTopView(message)
                        })
                    }else{
                        let message = Utils().getStringByKeyFromShare(ShareConstants().NO_TWITTER_ACCESS)
                        Utils().debugLog(message)
                        self.setAlertCompletionMessageOnTopView(message)
                    }
                }else{
                    let message = Utils().getStringByKeyFromShare(ShareConstants().NO_TWITTER_ACCESS)
                    Utils().debugLog(message)
                    self.setAlertCompletionMessageOnTopView(message)
                }
            }
        }else{
            let message = Utils().getStringByKeyFromShare(ShareConstants().TWITTER_MAX_LENGHT)
            Utils().debugLog(message)
            self.setAlertCompletionMessageOnTopView(message)
        }
        
    }
    
    func canUploadVideoToTwitter(movieURL:NSURL)->Bool{
        let asset = AVAsset.init(URL: movieURL)
        let duration = asset.duration.seconds
        
        if (duration <= 30){
            return true
        }else{
            return false
        }
    }
    
}