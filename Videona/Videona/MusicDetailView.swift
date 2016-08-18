//
//  MusicDetailView.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 27/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

protocol MusicDetailViewDelegate {
    func cancelButtonPushed()
    func acceptButtonPushed()
    func removeDetailButtonPushed()
}
protocol MusicDetailInterface {
    func showAcceptOrCancelButton()
    func showRemoveButton()
}

class MusicDetailView: UIView,MusicDetailInterface {
    
    //MARK: - Outlets
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    //MARK: - Variables
    var delegate:MusicDetailViewDelegate?
    
    //MARK: - Init
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "MusicDetailView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    func initParams(title:String,
         author:String,
         image:UIImage,
         frame:CGRect) {
        
        musicImage.image = image
        titleLabel.text = title
        authorLabel.text = author
        
        let offset = CGFloat(10)
        self.frame = CGRectMake((offset/2), 0, (frame.width - offset), (frame.height - offset) )
        
        self.applyPlainShadow()
    }
    
    func applyPlainShadow() {
        let layer = self.layer
        
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 5
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    //MARK: - Actions
    @IBAction func pushCancelButton(sender: AnyObject) {
        delegate?.cancelButtonPushed()
    }
    
    @IBAction func pushAcceptButton(sender: AnyObject) {
        delegate?.acceptButtonPushed()
    }
    @IBAction func pushRemoveButton(sender: AnyObject) {
        delegate?.removeDetailButtonPushed()
    }
    
    //MARK: - Show Actions
    func showAcceptOrCancelButton(){
        acceptButton.hidden = false
        cancelButton.hidden = false
        
        removeButton.hidden = true
    }
    
    func showRemoveButton(){
        acceptButton.hidden = true
        cancelButton.hidden = true
        
        removeButton.hidden = false
    }
}