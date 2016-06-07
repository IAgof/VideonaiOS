//
//  ShareSocialNetworkInteractor.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 6/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class ShareSocialNetworkInteractor{
    var moviePath:String = ""
    var socialName:String = ""
    var alertController:UIAlertController?
    
    init(moviePath:String,socialName:String){
        self.moviePath = moviePath
        self.socialName = socialName
    }
    
    func setShareMoviePath(moviePath:String){
        self.moviePath = moviePath
    }
    
    func getShareMovieURL()->NSURL{
        return NSURL.init(fileURLWithPath: self.moviePath)
    }
    
    func setAlertVideoUploadWaiting(){
        
    }
    func setAlertCompletionMessageOnTopView(message:String){
        // create the alert
        let alert = UIAlertController(title: socialName, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        // show the alert
        self.getViewControllerOnTop().presentViewController(alert, animated: true, completion: nil)
    }
    
    func getViewOnTop()->UIView{
        return (UIApplication.sharedApplication().keyWindow!.rootViewController?.view)!
    }
    
    func getViewControllerOnTop()->UIViewController{
        return UIApplication.sharedApplication().keyWindow!.rootViewController!
    }
    
    func createAlertWaitToExport(){
        alertController = UIAlertController(title: "Uploading Video", message: "Please Wait", preferredStyle: .Alert)
        
        let activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        
        activityIndicator.center = CGPointMake(130.5, 75.5);
        activityIndicator.startAnimating()
        
        alertController?.view.addSubview(activityIndicator)
        self.getViewControllerOnTop().presentViewController(alertController!, animated: false, completion:{})
    }
    
    func dissmissAlertWaitToExport(completion:()->Void){
        alertController?.dismissViewControllerAnimated(true, completion: {
            print("can go to next screen")
            completion()
        })
    }
    
}