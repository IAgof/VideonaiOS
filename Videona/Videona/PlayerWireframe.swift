//
//  PlayerWireframe.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 13/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

let playerViewIdentifier = "PlayerView"

class PlayerWireframe : NSObject{//, UIViewAnimationTransition {
    
    var playerPresenter : PlayerPresenter?
    var presentedView : UIView?
    var rootWireframe : RootWireframe?
    
    func presentPlayerInterfaceFromViewController(viewController: UIViewController) {
        let newView = playerView()
        
        newView.eventHandler = playerPresenter
        playerPresenter?.controller = newView
        
        playerPresenter?.configureUserInterfaceForPresentation(newView)
        
        if  viewController is ShareViewController
        {
            let shareViewController = viewController as! ShareViewController
            shareViewController.playerView.layoutIfNeeded()
            newView.frame = shareViewController.playerView.frame
            shareViewController.playerView.addSubview(newView)
            
            presentedView = newView
        }

    }
    
    func playerView() -> PlayerView {
        let playerView: PlayerView = PlayerView.instanceFromNib() as! PlayerView
        return playerView
    }
    
}