//
//  AddShareTitleUseCase.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 9/2/17.
//  Copyright © 2017 Videona. All rights reserved.
//

import Foundation

class AddShareTitleUseCase:NSObject{
   enum SocialNetwork {
        case Twitter
        case Youtube
    }
    
   struct AlertControllerModel {
        let title:String
        let message:String
        let save:String
        let cancel:String
    }
    
   func addTextOnShare(socialNetwork:SocialNetwork,completion:String?->Void){
        if let controller = UIApplication.topViewController(){
            let alertViewModel = getAlertControllerViewModel(fromSocialType: socialNetwork)

            let alertController = UIAlertController(title: alertViewModel.title, message: alertViewModel.message, preferredStyle: .Alert)
            
            alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
                textField.placeholder = alertViewModel.title
            }
            
            let saveAction = UIAlertAction(title: alertViewModel.save, style: .Default, handler: {alert -> Void in
                let firstTextFieldText = (alertController.textFields![0] as UITextField).text
                print("El \(alertViewModel.title) introducido para mandar al presenter es: \(firstTextFieldText!)")
                completion(firstTextFieldText)
            })
            
            let cancelAction = UIAlertAction(title: alertViewModel.cancel, style: .Cancel, handler: nil)
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
            controller.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    private func getAlertControllerViewModel(fromSocialType type:SocialNetwork)->AlertControllerModel{
        switch type {
        case .Twitter:
            return AlertControllerModel(title: AddShareTitleTextConstants.ADD_TWITTER_TITLE,
                                        message: AddShareTitleTextConstants.ADD_TWITTER_MESSAGE,
                                        save:   AddShareTitleTextConstants.SAVE ,
                                        cancel:   AddShareTitleTextConstants.CANCEL )

        case .Youtube:
            return AlertControllerModel(title: AddShareTitleTextConstants.ADD_YOUTUBE_TITLE,
                                        message: AddShareTitleTextConstants.ADD_YOUTUBE_MESSAGE,
                                        save:   AddShareTitleTextConstants.SAVE  ,
                                        cancel:   AddShareTitleTextConstants.CANCEL)

        }
    }
}
