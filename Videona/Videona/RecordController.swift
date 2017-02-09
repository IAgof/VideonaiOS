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
    var eventHandler: RecordPresenterInterface?
    
    //MARK: - Outlets
    @IBOutlet weak var warningOrientationImage: UIImageView!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var cameraRotationButton: UIButton!
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var shaderFilterButton: UIButton!
    @IBOutlet weak var overlayFilterButton: UIButton!
    @IBOutlet weak var cameraView: GPUImageView!
    @IBOutlet weak var chronometrer: UILabel!
    @IBOutlet weak var chronometrerContainer: UIView!
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var thumbnailNumberClips: UILabel!
    @IBOutlet weak var focusImageView: UIImageView!
    
    var alertController:UIAlertController?
    var tapDisplay:UIGestureRecognizer?
    var pinchDisplay:UIPinchGestureRecognizer?
    var defaultThumbImage:UIImage{
        guard let image = UIImage(named: "activity_record_gallery_normal") else{
            return UIImage()
        }
        return image
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        eventHandler?.viewDidLoad(cameraView)
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("Recorder view will appear")
        eventHandler?.viewWillAppear()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        eventHandler?.viewWillDisappear()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - View Config
    func forceLandsCapeOnInit(){
        //Force landscape mode
        let value = UIInterfaceOrientation.LandscapeLeft.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
    }
    
    func configureView() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RecordController.checkOrientation), name: UIDeviceOrientationDidChangeNotification, object: nil)
        self.navigationController?.navigationBarHidden = true
        self.forceLandsCapeOnInit()
        
        tapDisplay = UITapGestureRecognizer(target: self, action: #selector(RecordController.displayTapped))
        self.cameraView.addGestureRecognizer(tapDisplay!)
        
        pinchDisplay = UIPinchGestureRecognizer(target: self, action: #selector(RecordController.displayPinched))
        self.cameraView.addGestureRecognizer(pinchDisplay!)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(self.thumbnailTapped))
        thumbnailView.userInteractionEnabled = true
        thumbnailView.addGestureRecognizer(tapGestureRecognizer)
        
        self.thumbnailNumberClips.adjustsFontSizeToFitWidth = true
    }
    
    func thumbnailTapped(){
        Utils.sharedInstance.debugLog("Thumbnail has tapped")
        
        eventHandler?.thumbnailHasTapped()
    }
    
    func displayTapped(){
        eventHandler!.displayHasTapped(tapDisplay!)
    }
    func displayPinched(){
        eventHandler!.displayHasPinched(pinchDisplay!)
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
    
    func recordButtonEnable(state: Bool) {
        self.recordButton.enabled = state
    }
    
    func showSettings(){
        settingsButton.hidden = false
    }
    
    func hideSettings(){
        settingsButton.hidden = true 
    }
    
    func hideFilterList() {
        eventHandler?.hideAnyFilterList()
    }
    
    func showChronometer(){
        self.chronometrerContainer.hidden = false
    }
    
    func hideChronometer(){
        self.chronometrerContainer.hidden = true
    }
    
    func updateChronometer(time: String) {
        self.chronometrer.text = time
    }
    
    func showRecordedVideoThumb(image: UIImage) {
        thumbnailView.image = image
        thumbnailView.hidden = false
        
        setCornerToThumbnail()
        setBorderToThumb()
    }
    
    func showNumberVideos(nClips:Int){
        thumbnailNumberClips.text = "\(nClips)"
        thumbnailNumberClips.adjustsFontSizeToFitWidth = true
    }
    
    //Customize the thumnailImageView
    
    func setCornerToThumbnail(){
        let diameter = thumbnailView.frame.height/2
        
        thumbnailView.layer.cornerRadius = diameter
        thumbnailView.clipsToBounds = true
    }
    
    func setBorderToThumb(){
        let borderLayer = self.getBorderLayer()
        thumbnailView.layer.addSublayer(borderLayer)
    }
    
    func getBorderLayer() -> CALayer{
        let diameter = thumbnailView.frame.width/2
        let borderLayer = CALayer.init()
        let borderFrame = CGRectMake(0,0,thumbnailView.frame.height, thumbnailView.frame.height)
        
        //Set properties border layer
        borderLayer.backgroundColor = UIColor.clearColor().CGColor
        borderLayer.frame = borderFrame
        borderLayer.cornerRadius = diameter
        borderLayer.borderWidth = 3
        borderLayer.borderColor = UIColor.whiteColor().CGColor
        
        return borderLayer
    }
    
    ///////////////////////////////
    func hideRecordedVideoThumb(){
        thumbnailView.image = defaultThumbImage
        thumbnailNumberClips.text = ""
        
        guard let sublayers = thumbnailView.layer.sublayers else{
            return
        }
        for layer in sublayers{
            layer.removeFromSuperlayer()
        }
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

    func showOverlayOnTop(isOnTop: Bool) {
        overlayFilterButton.selected = isOnTop
    }
    
    func showShadersOnTop(isOnTop: Bool) {
        shaderFilterButton.selected = isOnTop
    }
    
    func showFlashSupported(state:Bool){
        flashButton.enabled = state
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
        shareButton.enabled = true
    }
    
    func disableShareButton(){
        shareButton.enabled = false
    }
    
    func finishActivityForResult(path:String){
        
    }
    
    func resetView() {
        eventHandler?.resetRecorder()
    }
    
    func getThumbnailSize()->CGFloat{
        return self.thumbnailView.frame.size.height
    }
    
    func showFocusAtPoint(point: CGPoint) {
        
        focusImageView.center = point
        focusImageView.hidden = false
        
        Utils.sharedInstance.delay(0.5, closure: {
            self.focusImageView.hidden = true
        })
    }
    
    //MARK: - Landscape Orientation
    func checkOrientation(){
        eventHandler?.changeOrientationEvent()
    }
    
    func setOrientation(){
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
        Utils.sharedInstance.debugLog("Orientation You have moved: \(text)")
    }
   
    func forceOrientation(){
        switch UIDevice.currentDevice().orientation{
        case .Portrait,.PortraitUpsideDown:
            let value = UIInterfaceOrientation.LandscapeRight.rawValue
            UIDevice.currentDevice().setValue(value, forKey: "orientation")
            Utils.sharedInstance.debugLog("Force orientation to landscape right)")
            break
        default:
            break
        }

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
            return controller.supportedInterfaceOrientations()
        }else{
            return UIInterfaceOrientationMask.Portrait
        }
    }
    public override func shouldAutorotate() -> Bool {
        if visibleViewController != nil{
            return visibleViewController!.shouldAutorotate()
        }else{
            return true
        }
    }
}

extension UIAlertController {
    override public func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.All
    }
    public override func shouldAutorotate() -> Bool {
        return false
    }
}

extension UIButton {
    public override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let buttonSize = self.frame.size
        let widthToAdd = (44-buttonSize.width > 0) ? 44-buttonSize.width : 0
        let heightToAdd = (44-buttonSize.height > 0) ? 44-buttonSize.height : 0
        let largerFrame = CGRect(x: 0-(widthToAdd/2), y: 0-(heightToAdd/2), width: buttonSize.width+widthToAdd, height: buttonSize.height+heightToAdd)
        return (CGRectContainsPoint(largerFrame, point)) ? self : nil
    }
}
