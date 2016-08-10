//
//  MusicViewController.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 27/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class MusicViewController: VideonaController,MusicViewInterface,MusicPresenterDelegate,MusicDetailViewDelegate,
UITableViewDataSource,UITableViewDelegate{
    //MARK: - VIPER variables
    var eventHandler: MusicPresenterInterface?
    
    //MARK: - Outlet
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var musicTableView: UITableView!
    @IBOutlet weak var musicContainer: UIView!
    
    //MARK: - Variables and constants
    let cellIdentifier = "musicCell"
    
    var titleList:[String] = []
    
    var imageList:[UIImage] = []{
        didSet{
            musicTableView.reloadData()
        }
    }
    
    var detailMusicView:MusicDetailView?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventHandler?.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    //MARK: - Tableview delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        eventHandler?.didSelectMusicAtIndexPath(indexPath)
    }
    
    //MARK: - Tableview dataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! MusicCell
        
        if imageList.indices.contains(indexPath.item) && !imageList.isEmpty{
           let image = imageList[indexPath.item]
            cell.musicImage.image = image
        }
        
        if titleList.indices.contains(indexPath.item){
            let text = titleList[indexPath.item]
            cell.titleLabel.text = text
        }
                
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if imageList.indices.contains(indexPath.item) {
            return imageList[indexPath.row].size.height
        }else{
            return 80
        }
    }
    
    //MARK: - Presenter delegate
    func setTextList(titleList: [String]) {
        self.titleList = titleList
    }
    
    func setMusicImageList(imageList: [UIImage]) {
        self.imageList = imageList
    }
    
    //MARK: - Music Detail Delegate
    func acceptButtonPushed() {
        eventHandler?.acceptDetailButtonPushed()
    }
    func cancelButtonPushed() {
        eventHandler?.cancelDetailButtonPushed()
    }
    func removeDetailButtonPushed() {
        eventHandler?.removeDetailButtonPushed()
    }
    
    //MARK: - Change views
    func removeTableFromView() {
        musicTableView.hidden = true
    }
    
    func setTableToView() {
        musicTableView.hidden = false
    }
    
    func removeDetailFromView() {
        detailMusicView?.removeFromSuperview()
    }
    
    func animateToShowTable(){
        UIView.animateWithDuration(0.5, animations: {
            self.musicTableView.alpha = 1
            self.detailMusicView!.alpha = 0.2
            },
                                   completion: { finished in
                                    self.setTableToView()
                                    self.removeDetailFromView()
        })
    }
    
    func animateToShowDetail(title:String,
                             author:String,
                             image:UIImage) {
        self.setUpDetailView(title, author: author, image: image)
        
        UIView.animateWithDuration(0.3, animations: {
            self.detailMusicView!.alpha = 1
            self.musicTableView.alpha = 0.2
            },
                                   completion: { finished in
                                    self.setDetailToView()
                                    self.removeTableFromView()
        })
    }
    
    func setDetailToView() {
        musicContainer.addSubview(detailMusicView!)
    }
    
    func setUpDetailView(title:String,
                         author:String,
                         image:UIImage){
        
        let view = MusicDetailView.instanceFromNib()
        
        detailMusicView = view as? MusicDetailView
                
        eventHandler?.setMusicDetailInterface(detailMusicView!)

        detailMusicView?.delegate = self
        
        Utils.sharedInstance.debugLog("Size of detail container:\(musicContainer.frame)")

        detailMusicView?.initParams(title,
                                    author: author,
                                    image: image,
                                    frame: musicContainer.frame)
    }
}