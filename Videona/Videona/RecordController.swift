//
//  ViewController.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 3/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import UIKit

class RecordController: VideonaController,RecordViewInterface,UINavigationControllerDelegate {
    
    //MARK: - Variables VIPER
    var eventHandler: RecordPresenter?
    
    @IBOutlet weak var warningOrientationImage: UIImageView!
    
    //MARK: - View Config
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RecordController.checkOrientation), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    func forceLandsCapeOnInit(){
        //Force landscape mode
        let value = UIInterfaceOrientation.LandscapeLeft.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configureView() {
        self.navigationController?.navigationBarHidden = true
        self.forceLandsCapeOnInit()
    }
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return UIInterfaceOrientation.LandscapeLeft
    }
    //MARK: - Button Actions
    @IBAction func pushGoToSettings(sender: AnyObject) {
        eventHandler?.pushSettings()
    }
    
    @IBAction func pushGoToShareView(sender: AnyObject) {
        eventHandler?.pushShare()
    }
    
    @IBAction func pushColorFilter(sender: AnyObject) {
        eventHandler?.pushShowHideColorFilters()
    }
    @IBAction func pushShaderFilter(sender: AnyObject) {
        eventHandler?.pushShowHideShaderFilters()
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
        warningOrientationImage.hidden = false
    }
    
    func unlockScreenRotation(){
        warningOrientationImage.hidden = true
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
    
    func checkOrientation(){
        var text=""
        switch UIDevice.currentDevice().orientation{
        case .Portrait:
            text="Portrait"
            eventHandler?.showWarningOrientationImage()
        case .PortraitUpsideDown:
            text="PortraitUpsideDown"
            eventHandler?.showWarningOrientationImage()
        case .LandscapeLeft:
            text="LandscapeLeft"
            eventHandler?.hideWarningOrientationImage()
        case .LandscapeRight:
            text="LandscapeRight"
            eventHandler?.hideWarningOrientationImage()
        default:
            text="Another"
        }
//        NSLog("You have moved: \(text)")
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
            return UIInterfaceOrientationMask.Landscape
    }
    override func shouldAutorotate() -> Bool {
        return true
    }
    
}
extension UINavigationController {
    
    override public func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if let controller = visibleViewController{
            print("controller = visibleViewController")
            return controller.supportedInterfaceOrientations()
        }else{
            print("ELSE -- controller = visibleViewController")
            return UIInterfaceOrientationMask.Portrait
        }
    }
    public override func shouldAutorotate() -> Bool {
        return visibleViewController!.shouldAutorotate()
    }
}

