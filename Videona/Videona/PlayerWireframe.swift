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
    var presentedView : PlayerView?
    var rootWireframe : RootWireframe?
    
    func presentPlayerInterfaceFromViewController(viewController: UIViewController) {
        let playerView : PlayerView
        
        if presentedView == nil{
            playerView = self.playerView()
        }else{
            playerView = presentedView!
        }
        
        playerView.eventHandler = playerPresenter
        playerPresenter?.controller = playerView
        
        presentedView = playerView
        
        if  viewController is ShareViewController
        {
            let controller = viewController as! ShareViewController
            controller.playerView.addSubview(playerView)
            
        }else if  viewController is EditorViewController
        {
            let controller = viewController as! EditorViewController
            controller.playerView.addSubview(playerView)
            playerView.delegate = controller
            
        }else if  viewController is MusicViewController
        {
            let controller = viewController as! MusicViewController
            controller.playerView.addSubview(playerView)
            
        }else if  viewController is TrimViewController
        {
            let controller = viewController as! TrimViewController
            controller.playerView.addSubview(playerView)
    
        }else if  viewController is DuplicateViewController
        {
            let controller = viewController as! DuplicateViewController
            controller.playerView.addSubview(playerView)
            
        }else if  viewController is SplitViewController
        {
            let controller = viewController as! SplitViewController
            controller.playerView.addSubview(playerView)
            playerView.delegate = controller
        }

    }
    
    func playerView() -> PlayerView {
        let playerView: PlayerView = PlayerView.instanceFromNib() as! PlayerView
        return playerView
    }
    
}