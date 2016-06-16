//
//  FullScreenPlayerViewController.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 15/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class FullScreenPlayerViewController: UIViewController ,FullScreenPlayerInterface{

    //MARK: - VIPER
    var eventHandler: FullScreenPlayerPresenterInterface?

    var playerView:PlayerView?{
        didSet {
            self.view.addSubview(playerView!)
        }
    }

    @IBAction func pushShrinkButton(sender: AnyObject) {
        eventHandler?.onPushShrinkButton()
    }

    func getPlayerView()->PlayerView{
        return playerView!
    }
}
