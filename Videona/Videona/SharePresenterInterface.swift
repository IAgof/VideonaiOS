//
//  SharePresenterInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 11/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

protocol SharePresenterInterface {
    
    func viewDidLoad()
    func pushBack()
    func getListData()
    func setListTitleData(titleArray:Array<String>)
    func setListImageData(imageArray:Array<UIImage>)
    func setVideoExportedPath(path:String)
    func pushShare(socialNetwork:String)
    func postToYoutube(token:String)
}