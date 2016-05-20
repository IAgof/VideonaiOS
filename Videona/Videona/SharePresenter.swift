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
    var controller: ShareInterface?
    var interactor: ShareInteractor?
    var recordWireframe: RecordWireframe?
    var playerPresenter: PlayerPresenter?
    
    //LifeCicle
    func viewDidLoad() {
        controller!.registerNib()
        wireframe?.presentPlayerInterface()
        
        playerPresenter?.createVideoPlayer()
        self.getListData()
    }
    
    func pushBack() {
        print("Navigator presenter pushEdit")
        let recordViewController = recordWireframe?.RecordViewControllerFromStoryboard()
        
        controller?.navigateToNewViewController(recordViewController!)
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
}