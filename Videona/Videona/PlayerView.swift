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
    
    @IBOutlet weak var playOrPauseButton: UIButton!
   
    @IBOutlet weak var playerContainer: UIView!
    
    class func instanceFromNib() -> UIView {
        let view = UINib(nibName: "PlayerView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        return view
    }
    
    override func awakeFromNib() {
        
    }
    
    func setPlayerMovieURL(movieURL: NSURL) {
        self.movieURL = movieURL
    }
    
    override func layoutSubviews() {
        self.eventHandler?.layoutSubViews()
    }
    
    func updateLayers(){
        let superViewFrame = (self.superview?.frame)!
        self.frame = CGRectMake(0, 0, superViewFrame.width, superViewFrame.height)
    }
    
    func getView() -> UIView {
        return self
    }
    
    func createVideoPlayer(){
        self.setViewPlayerTappable()
        
        let avAsset: AVURLAsset = AVURLAsset(URL: movieURL!, options: nil)
        let playerItem: AVPlayerItem = AVPlayerItem(asset: avAsset)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PlayerView.onVideoStops),
                                                         name: AVPlayerItemDidPlayToEndTimeNotification,
                                                         object: playerItem)
        player = AVPlayer.init(playerItem: playerItem)
        
        //Get video duration to player progressView
//        videoDuration = avAsset.duration.seconds
        
        let layer = AVPlayerLayer(player: player)
        layer.frame = self.frame
        player?.currentItem?.seekToTime(CMTime.init(value: 1, timescale: 10))

        self.playerContainer.layoutIfNeeded()
        self.playerContainer.layer.addSublayer(layer)
    }
    
    func setViewPlayerTappable(){
        let singleFingerTap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action:#selector(PlayerView.videoPlayerViewTapped))
        playerContainer.addGestureRecognizer(singleFingerTap)
    }
    
    func videoPlayerViewTapped(){
        eventHandler?.videoPlayerViewTapped()
    }
    @IBAction func pushPlayButton(sender: AnyObject) {
        eventHandler?.pushPlayButton()
    }
    
    func setUpVideoFinished(){
        player?.currentItem?.seekToTime(CMTime.init(value: 1, timescale: 10))
        playOrPauseButton.hidden = false
    }
    
    func onVideoStops(){
        eventHandler?.onVideoStops()
    }
    
    func pauseVideoPlayer(){
        player!.pause()
        
        playOrPauseButton.hidden = false
        
        Utils().debugLog("Video has stopped")
    }
    
    func playVideoPlayer(){
        player!.play()
        
        playOrPauseButton.hidden = true
        
        //Start timer

        Utils().debugLog("Playing video")
    }
}