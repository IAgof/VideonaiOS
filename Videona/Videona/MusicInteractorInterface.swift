//
//  MusicInteractorInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 27/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

protocol MusicInteractorInterface {
    func getMusicList()
    func getTitleFromIndexPath(index:Int)->String
    func getAuthorFromIndexPath(index:Int)->String
    func getImageFromIndexPath(index:Int)->UIImage
}

protocol MusicInteractorDelegate {
    func setTextList(titleList:[String])
    func setImageList(imageList:[UIImage])
}