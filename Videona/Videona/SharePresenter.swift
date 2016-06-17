//
//  SharePresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 11/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class SharePresenter:NSObject,SharePresenterInterface{
    
    var wireframe: ShareWireframe?
    var controller: ShareViewController?
    var interactor: ShareInteractor?
    var recordWireframe: RecordWireframe?
    var playerPresenter: PlayerPresenter?
    var playerWireframe: PlayerWireframe?

    var fullScreenPlayerWireframe: FullScreenPlayerWireframe?
    
    var videoPath = ""
    
    //LifeCicle
    func viewDidLoad() {
        controller!.createShareInterface()
        controller?.setNavBarTitle(Utils().getStringByKeyFromSettings(SettingsConstants().SHARE_VIDEONA_TITLE))
        
        wireframe?.presentPlayerInterface()
        
        playerPresenter?.createVideoPlayer(videoPath)
        self.getListData()
        
        controller?.bringToFrontExpandPlayerButton()
    }
    
    func setVideoExportedPath(path: String) {
        self.videoPath = path
        
    }
    
    func pushBack() {
        wireframe?.goPrevController()
    }
    
    func expandPlayer(){
        fullScreenPlayerWireframe?.presentFullScreenPlayerFromViewController(controller!,playerView: (playerWireframe?.presentedView)!)
    }
    
    func getListData (){
       let socialNetworks = interactor?.findSocialNetworks()
        
        self.setListImageData((socialNetworks?.socialNetworkImageArray)!)
        self.setListTitleData((socialNetworks?.socialNetworkTitleArray)!)
        self.setListImagePressedData((socialNetworks?.socialNetworkImagePressedArray)!)
    }
    
    func setListTitleData(titleArray:Array<String>){
        controller?.setTitleList(titleArray)
    }
    
    func setListImageData(imageArray:Array<UIImage>){
        controller?.setImageList(imageArray)
    }
    
    func setListImagePressedData(imageArray:Array<UIImage>){
        controller?.setImagePressedList(imageArray)
    }
    func pushShare(socialNetwork: String) {
        interactor?.shareVideo(socialNetwork, videoPath: videoPath)
    }
    
    func postToYoutube(token:String){
        interactor!.postToYoutube(token)
    }

    func updatePlayerLayer() {
        playerPresenter!.layoutSubViews()
    }
}