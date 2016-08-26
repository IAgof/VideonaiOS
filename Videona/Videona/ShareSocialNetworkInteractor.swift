//
//  ShareSocialNetworkInteractor.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 6/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import Photos

class ShareSocialNetworkInteractor:NSObject{
    var moviePath:String = ""
    var socialName:String = ""
    var alertController:UIAlertController?
    
    init(socialName:String){
        self.moviePath = Project.sharedInstance.getExportedPath()
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
        alertController = UIAlertController(title: socialName, message: message, preferredStyle: .Alert)
        
        // add the actions (buttons)
        alertController!.addAction(UIAlertAction(title: Utils().getStringByKeyFromShare(ShareConstants().OK),
            style: .Default, handler: nil))
        
        // show the alert
        self.getViewControllerOnTop().presentViewController(alertController!, animated: false, completion:{})
    }
    
    func getViewOnTop()->UIView{
        if var topController = UIApplication.sharedApplication().keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController.view
            // topController should now be your topmost view controller
        }else{
            return (UIApplication.sharedApplication().keyWindow?.rootViewController)!.view
        }    }
    
    func getViewControllerOnTop()->UIViewController{
        if var topController = UIApplication.sharedApplication().keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
            // topController should now be your topmost view controller
        }else{
            return (UIApplication.sharedApplication().keyWindow?.rootViewController)!
        }
    }
    
    func createAlertWaitToExport(){
        alertController = UIAlertController(title: Utils().getStringByKeyFromShare(ShareConstants().UPLOADING_VIDEO),
                                            message: Utils().getStringByKeyFromShare(ShareConstants().PLEASE_WAIT),
                                            preferredStyle: .Alert)
        
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
    
    func getLastAsset() -> PHAsset
    {
        var asset:PHAsset = PHAsset()
        
        //Get last videoAsset on PhotoLibrary
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending:false)]
        let fetchResult = PHAsset.fetchAssetsWithMediaType(.Video, options: fetchOptions)
       
        if let lastAsset = fetchResult.firstObject as? PHAsset {
            asset = lastAsset
        }
        return asset
    }
    
    func getLastAssetURL() ->NSURL{
        let asset = self.getLastAsset()
        let localID = asset.localIdentifier
        let assetID =
            localID.stringByReplacingOccurrencesOfString(
                "/.*", withString: "",
                options: NSStringCompareOptions.RegularExpressionSearch, range: nil)
        let ext = "mp4"
        let assetURLStr =
            "assets-library://asset/asset.\(ext)?id=\(assetID)&ext=\(ext)"
        
        return NSURL(string: assetURLStr)!
    }
    
    func getLastAssetString() -> String{
        let asset = self.getLastAsset()
        
        return asset.localIdentifier
    }
}