//
//  FullScreenPlayerPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 15/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class FullScreenPlayerPresenter:FullScreenPlayerPresenterInterface{
    //MARK: - VIPER
    var wireframe: FullScreenPlayerWireframe?
    var controller: FullScreenPlayerInterface?
    var shareWireframe: ShareWireframe?

    func onPushShrinkButton() {
        wireframe?.goPrevController((controller?.getPlayerView())!)
    }
}