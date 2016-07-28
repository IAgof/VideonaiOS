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
}
protocol MusicDestailInterface {
    func showAcceptOrCancelButton()
    func showRemoveButton()
}

class MusicDetailView: UIView,MusicDestailInterface {
    
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
        
        self.frame = CGRectMake(0, 0, frame.width, (frame.height - 10) )
        
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
    
    //MARK: - Show Actions
    func showAcceptOrCancelButton(){
        acceptButton.hidden = false
        cancelButton.hidden = false
        
        removeButton.hidden = true
    }
    
    func showRemoveButton(){
        acceptButton.hidden = false
        cancelButton.hidden = false
        
        removeButton.hidden = true
    }
}