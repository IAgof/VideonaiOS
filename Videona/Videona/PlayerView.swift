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
    var playerLayerFrame:CGRect?

    class func instanceFromNib() -> UIView {
        let view = UINib(nibName: "PlayerView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        return view
    }
    
    func setPlayerMovieURL(movieURL: NSURL) {
        self.movieURL = movieURL
    }
    override func layoutSubviews() {
        print("layoutSubviews\(self.frame)")
        for sublayer in videoPlayerView.layer.sublayers!{
            sublayer.frame = self.frame
        }
    }
    func createVideoPlayer(){
        videoPlayerView.layoutIfNeeded()

        let avAsset: AVURLAsset = AVURLAsset(URL: movieURL!, options: nil)
        let playerItem: AVPlayerItem = AVPlayerItem(asset: avAsset)
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SharedViewController.onVideoStops),
//                                                         name: AVPlayerItemDidPlayToEndTimeNotification,
//                                                         object: playerItem)
        player = AVPlayer.init(playerItem: playerItem)
        
        //Get video duration to player progressView
//        videoDuration = avAsset.duration.seconds
        
        let layer = AVPlayerLayer.init()
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill
        layer.player = player
        
        layer.backgroundColor = UIColor.blackColor().CGColor
        
        self.videoPlayerView.layer.addSublayer(layer)
        
        player?.play()
    }
}