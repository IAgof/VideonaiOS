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
    //MARK: - VIPER
    var eventHandler: PlayerPresenterInterface?
    var delegate:PlayerViewDelegate?
    
    //MARK: - Variables
    var player:AVPlayer?
    var playerLayer: AVPlayerLayer?
    var movieComposition:AVMutableComposition!
    var oldSliderValue:Float = 0.0

    //MARK: - Outlets
    @IBOutlet weak var playOrPauseButton: UIButton!
    @IBOutlet weak var playerContainer: UIView!
    @IBOutlet weak var seekSlider: UISlider!
    
    var playerRateBeforeSeek: Float = 0

    class func instanceFromNib() -> UIView {
        let view = UINib(nibName: "PlayerView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        return view
    }
    
    override func awakeFromNib() {
        
    }
    
    func setPlayerMovieComposition(composition: AVMutableComposition) {
        self.movieComposition = composition
    }
    
    override func layoutSubviews() {
        self.eventHandler?.layoutSubViews()
    }
    
    func updateLayers(){
        self.superview?.layoutIfNeeded()
        let superViewFrame = (self.superview?.frame)!
        self.frame = CGRectMake(0, 0, superViewFrame.width, superViewFrame.height)

        if (playerLayer != nil){
            playerLayer!.frame = self.frame
            self.playerContainer.frame = self.frame
        }
    }
    
    func getView() -> UIView {
        return self
    }
    
    func removeSubviews(){
        if let sublayers = self.playerContainer.layer.sublayers{
            for layer in sublayers{
                layer.removeFromSuperlayer()
            }
        }
    }
    //MARK: - Player Interface
    func createVideoPlayer(){
        removeSubviews()
        
        self.setViewPlayerTappable()
        self.initSeekEvents()
        
        if (movieComposition != nil) {
            
            let playerItem: AVPlayerItem = AVPlayerItem(asset: movieComposition)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PlayerView.onVideoStops),
                                                             name: AVPlayerItemDidPlayToEndTimeNotification,
                                                             object: playerItem)
            player = AVPlayer.init(playerItem: playerItem)
            
            player!.addPeriodicTimeObserverForInterval(CMTimeMake(1, 1000), queue: dispatch_get_main_queue()) { _ in
                if self.player!.currentItem?.status == .ReadyToPlay {
                    self.eventHandler?.updateSeekBar()
                }
            }
            
            
            playerLayer = AVPlayerLayer(player: player)
            playerLayer!.frame = self.frame
            player?.currentItem?.seekToTime(CMTime.init(value: 3, timescale: 10))
            
            self.playerContainer.layoutIfNeeded()
            self.playerContainer.layer.addSublayer(playerLayer!)
            
            self.playerContainer.bringSubviewToFront(seekSlider)

        }
    }
    
    func updateSeekBarOnUI(){
        guard let duration = player?.currentItem?.duration.seconds else{
            return
        }
        guard let currentTime = player?.currentTime().seconds else{
            return 
        }
        
        let sliderValue = Float((currentTime / duration))
        
        seekSlider.setValue(sliderValue, animated: true)
        if oldSliderValue != sliderValue {
            self.delegate?.seekBarUpdate(sliderValue)
        }
        oldSliderValue = sliderValue
    }
    
    func setViewPlayerTappable(){
        let singleFingerTap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action:#selector(PlayerView.videoPlayerViewTapped))
        playerContainer.addGestureRecognizer(singleFingerTap)
    }
    
    func initSeekEvents(){
        seekSlider.addTarget(self, action: #selector(PlayerView.sliderBeganTracking),
                             forControlEvents: UIControlEvents.TouchDown)
        seekSlider.addTarget(self, action: #selector(PlayerView.sliderEndedTracking),
                             forControlEvents: UIControlEvents.TouchUpInside)        
        seekSlider.addTarget(self, action: #selector(PlayerView.sliderValueChanged),
                             forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func videoPlayerViewTapped(){
        eventHandler?.videoPlayerViewTapped()
    }
    
    @IBAction func pushPlayButton(sender: AnyObject) {
        eventHandler?.pushPlayButton()
    }
    
    func sliderBeganTracking(){
        playerRateBeforeSeek = player!.rate
        player!.pause()
    }
    
    func sliderEndedTracking(){
//        let videoDuration = CMTimeGetSeconds(player!.currentItem!.duration)
//        let elapsedTime: Int64 = Int64(videoDuration * 1000 * Float64(seekSlider.value))
//        
//        let timeToGo = CMTimeMake(elapsedTime, 1000)
//        let tolerance = CMTimeMake(1, 100)
//        
//        player?.seekToTime(timeToGo, toleranceBefore: tolerance, toleranceAfter: tolerance, completionHandler: {
//            completed in
//            if (self.playerRateBeforeSeek > 0) {
//                self.player!.play()
//            }
//            
//            if completed{
//                self.delegate?.seekBarUpdate(Float(self.seekSlider.value))
//            }
//        })
    }
    
    func sliderValueChanged(){
        let videoDuration = CMTimeGetSeconds(player!.currentItem!.duration)
        let elapsedTime: Int64 = Int64(videoDuration * 1000 * Float64(seekSlider.value))
        
        let timeToGo = CMTimeMake(elapsedTime, 1000)
        let tolerance = CMTimeMake(1, 100)
        
        player?.seekToTime(timeToGo, toleranceBefore: tolerance, toleranceAfter: tolerance, completionHandler: {
            completed in
            if (self.playerRateBeforeSeek > 0) {
                self.player!.play()
            }
            
            if completed{
                self.delegate?.seekBarUpdate(Float(self.seekSlider.value))
            }
        })
    }
    
    func setUpVideoFinished(){
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            Utils().debugLog("Set up video finished")
            
            self.player?.pause()
            self.player?.currentItem?.seekToTime(CMTime.init(value: 1, timescale: 10))
            self.playOrPauseButton.hidden = false
        })
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
    
    func seekToTime(time: Float) {
        Utils.sharedInstance.debugLog("Seek to time manually to --\(time)")
        seekSlider.value = time
        let videoDuration = CMTimeGetSeconds(player!.currentItem!.duration)
        let elapsedTime: Int64 = Int64(videoDuration * 1000 * Float64(seekSlider.value))
        
        let timeToGo = CMTimeMake(elapsedTime, 1000)
        let tolerance = CMTimeMake(1, 100)
        player?.seekToTime(timeToGo, toleranceBefore: tolerance, toleranceAfter: tolerance)
        
    }
    
}