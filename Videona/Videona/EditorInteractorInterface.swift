//
//  EditorInteractorInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 9/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

protocol EditorInteractorInterface {
    func getListData()
}

protocol EditorInteractorDelegate {
    func setPositionList(list:[Int])
    func setVideoImagesList(list:[UIImage])
}