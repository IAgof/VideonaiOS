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
    
    var transitioningBackgroundView : UIView = UIView()
    var movieURL:NSURL!
    var player:AVPlayer?
    
    class func instanceFromNib() -> UIView {
        let view = UINib(nibName: "PlayerView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        return view
    }
    
    func setPlayerMovieURL(movieURL: NSURL) {
        self.movieURL = movieURL
    }
    
    override func layoutSubviews() {
        self.eventHandler?.layoutSubViews()
    }
    
    func updateLayers(frame:CGRect){
        if let sublayers = self.layer.sublayers{
            for sublayer in sublayers{
                sublayer.frame = frame
            }
        }
    }
    
    func getView() -> UIView {
        return self
    }
    
    func createVideoPlayer(){
        let avAsset: AVURLAsset = AVURLAsset(URL: movieURL!, options: nil)
        let playerItem: AVPlayerItem = AVPlayerItem(asset: avAsset)
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SharedViewController.onVideoStops),
//                                                         name: AVPlayerItemDidPlayToEndTimeNotification,
//                                                         object: playerItem)
        player = AVPlayer.init(playerItem: playerItem)
        
        //Get video duration to player progressView
//        videoDuration = avAsset.duration.seconds
        
        let layer = AVPlayerLayer()
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill
        layer.player = player
        
        layer.backgroundColor = UIColor.blackColor().CGColor
        
        self.layer.addSublayer(layer)
        player?.play()
    }
}