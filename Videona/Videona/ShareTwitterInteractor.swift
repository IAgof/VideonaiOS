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

class ShareTwitterInteractor: ShareSocialNetworkInteractor {
    
    func share(){
        let videoURL = self.getShareMovieURL()
        let accountStore:ACAccountStore = ACAccountStore.init()
        let accountType:ACAccountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (let granted, let error) in
            let accounts = accountStore.accountsWithAccountType(accountType)
            
            self.createAlertWaitToExport()
            if accounts.count > 0 {
                let twitterAccount = accounts[0]
                if(SocialVideoHelper.userHasAccessToTwitter()){
                    let videoData = NSData(contentsOfURL: videoURL)
                    SocialVideoHelper.uploadTwitterVideo(videoData, comment: "#Videona", account: twitterAccount as! ACAccount, withCompletion: {succes,error in
                        print("Video upload completion \(succes) \n \(error)")
                        let message = "Video upload successfully"
                        self.dissmissAlertWaitToExport({_ in
                            self.setAlertCompletionMessageOnTopView(message)
                        })
                    })
                }else{
                    let message = "No access to Twitter"
                    Utils().debugLog(message)
                    self.setAlertCompletionMessageOnTopView(message)
                }
            }
        }
    }
}