//
//  ViewController.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 3/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import UIKit

class RecordController: UIViewController,RecordViewInterface {
    
    //MARK: - Variables VIPER
    var output: RecordPresenter?
    
    
    //MARK: - View Config
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configureView() {
        self.navigationController?.navigationBarHidden = true
    }
    
    //MARK: - Button Actions
    @IBAction func pushGoToSettings(sender: AnyObject) {
        output?.pushSettings()
    }
    
    @IBAction func pushGoToShareView(sender: AnyObject) {
        output?.pushShare()
    }
    
    //MARK: - Protocol Interface
    func showRecordButton(){
        
    }
    
    func showStopButton(){
        
    }
    
    func showSettings(){
        
    }
    
    func hideSettings(){
        
    }
    
    func showChronometer(){
        
    }
    
    func hideChronometer(){
        
    }
    
    func showRecordedVideoThumb(path:String){
        
    }
    
    func hideRecordedVideoThumb(){
        
    }
    
    func showVideosRecordedNumber(numberOfVideos:Int){
        
    }
    
    func hideVideosRecordedNumber(){
        
    }
    
    func startChronometer(){
        
    }
    
    func stopChronometer(){
        
    }
    
    //    func showCameraEffectShader(List<Effect> effects)
    //
    //    func showCameraEffectOverlay(List<Effect> effects)
    
    func lockScreenRotation(){
        
    }
    
    func unlockScreenRotation(){
        
    }
    
    func reStartScreenRotation(){
        
    }
    
    func showFlashOn(on:Bool){
        
    }
    
    func showFlashSupported(state:Bool){
        
    }
    
    func showFrontCameraSelected(){
        
    }
    
    func showBackCameraSelected(){
        
    }
    
    func showError(errorMessage:String) {//videonaView
        
    }
    
    func showErrorID(stringResourceId:Int){ //videonaView
        
    }
    
    func goToShare(videoToSharePath:String){
        
    }
    
    func showProgressDialog(){
        
    }
    
    func hideProgressDialog(){
        
    }
    
    func showMessage(stringToast:Int){
        
    }
    
    func enableShareButton(){
        
    }
    
    func disableShareButton(){
        
    }
    
    func finishActivityForResult(path:String){
        
    }
    
    //MARK: - Navigation
    func navigateToNewViewController(controller: UIViewController) {
        self.presentViewController(controller, animated: true, completion: nil)
    }
}

