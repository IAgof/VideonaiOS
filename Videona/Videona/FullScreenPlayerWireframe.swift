//
//  FullScreenPlayerWireframe.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 15/6/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

let fullScreenPlayerViewControllerIdentifier = "FullScreenPlayerViewController"

class FullScreenPlayerWireframe : NSObject {
    var rootWireframe : RootWireframe?
    var fullScreenPlayerViewController: FullScreenPlayerViewController?
    var fullScreenPlayerPresenter: FullScreenPlayerPresenter?

    var prevController:UIViewController?

    func presentFullScreenPlayerFromViewController(prevController:UIViewController, playerView:PlayerView) {
        let viewController = fullScreenPlayerViewControllerFromStoryboard()

        viewController.playerView = playerView
        self.prevController = prevController

        prevController.showViewController(viewController, sender: nil)
    }

    func fullScreenPlayerViewControllerFromStoryboard() -> FullScreenPlayerViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewControllerWithIdentifier(fullScreenPlayerViewControllerIdentifier) as! FullScreenPlayerViewController

        viewController.eventHandler = fullScreenPlayerPresenter
        fullScreenPlayerViewController = viewController
        fullScreenPlayerPresenter?.controller = viewController

        return viewController
    }

    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return storyboard
    }

//    func presentPlayerInterface() {
//        playerWireframe?.presentPlayerInterfaceFromViewController(fullScreenPlayerViewController!)
//    }

    func goPrevController(playerView:PlayerView){
        if prevController!.isKindOfClass(ShareViewController) {
            let shareController = prevController as! ShareViewController
            shareController.cameFromFullScreenPlayer(playerView)
        }
        fullScreenPlayerViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}