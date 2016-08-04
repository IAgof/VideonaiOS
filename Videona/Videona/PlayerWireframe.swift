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
            let shareViewController = viewController as! ShareViewController
            shareViewController.playerView.addSubview(playerView)
            
        }else if  viewController is EditorViewController
        {
            let shareViewController = viewController as! EditorViewController
            shareViewController.playerView.addSubview(playerView)
            
        }else if  viewController is MusicViewController
        {
            let shareViewController = viewController as! MusicViewController
            shareViewController.playerView.addSubview(playerView)
            
        }else if  viewController is TrimViewController
        {
            let shareViewController = viewController as! TrimViewController
            shareViewController.playerView.addSubview(playerView)
    
        }else if  viewController is DuplicateViewController
        {
            let duplicateViewController = viewController as! DuplicateViewController
            duplicateViewController.playerView.addSubview(playerView)
            
        }

    }
    
    func playerView() -> PlayerView {
        let playerView: PlayerView = PlayerView.instanceFromNib() as! PlayerView
        return playerView
    }
    
}