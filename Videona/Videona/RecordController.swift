//
//  ViewController.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 3/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import UIKit
import GPUImage

class RecordController: VideonaController,RecordViewInterface,UINavigationControllerDelegate {
    
    //MARK: - Variables VIPER
    var eventHandler: RecordPresenter?
    
    @IBOutlet weak var warningOrientationImage: UIImageView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var cameraRotationButton: UIButton!
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var shaderFilterButton: UIButton!
    @IBOutlet weak var overlayFilterButton: UIButton!
    @IBOutlet weak var cameraView: GPUImageView!
    
    //MARK: - View Config
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        eventHandler?.viewDidLoad(cameraView)
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RecordController.checkOrientation), name: UIDeviceOrientationDidChangeNotification, object: nil)
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
    
    @IBAction func pushRecord(sender: AnyObject) {
        eventHandler?.pushRecord()
    }
    
    @IBAction func pushFlash(sender: AnyObject) {
        eventHandler?.pushFlash()
    }
    
    @IBAction func pushRotateCamera(sender: AnyObject) {
        eventHandler?.pushRotateCamera()
    }
    
    //MARK: - Protocol Interface
    func showRecordButton(){
        self.recordButton.selected = true
    }
    
    func showStopButton(){
        self.recordButton.selected = false
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
        flashButton.selected = on
    }
    
    func showFlashSupported(state:Bool){
        
    }
    
    func showFrontCameraSelected(){
        cameraRotationButton.selected = true
    }
    
    func showBackCameraSelected(){
        cameraRotationButton.selected = false
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

