//
//  PlayerView.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 13/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class PlayerView: UIView,PlayerInterface {
    
    var eventHandler: PlayerPresenterInterface?
    
    @IBOutlet weak var videoPlayerView: UIView!
    
    var transitioningBackgroundView : UIView = UIView()
    var movieURL:NSURL!
    var player:AVPlayer?

    class func instanceFromNib() -> UIView {
        return UINib(nibName: "PlayerView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    func setPlayerMovieURL(movieURL: NSURL) {
        self.movieURL = movieURL
    }
    
    func createVideoPlayer(){
        Utils().debugLog("Starts video player")
        
        let avAsset: AVURLAsset = AVURLAsset(URL: movieURL!, options: nil)
        let playerItem: AVPlayerItem = AVPlayerItem(asset: avAsset)
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SharedViewController.onVideoStops),
//                                                         name: AVPlayerItemDidPlayToEndTimeNotification,
//                                                         object: playerItem)
        player = AVPlayer.init(playerItem: playerItem)
        
        //Get video duration to player progressView
//        videoDuration = avAsset.duration.seconds
        
        let layer = AVPlayerLayer.init()
        layer.player = player
        
//        self.videoPlayerView.layoutIfNeeded()
        let offsset = CGFloat(-20)
      
        layer.frame = self.frame
        
//        layer.frame = CGRectMake(0,0, (self.videoPlayerView.bounds.width + offsset) , (self.videoPlayerView.bounds.height + offsset))
        
        self.videoPlayerView.layer.addSublayer(layer)
        
        player?.play()
    }
}