//
//  Transition.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

/**
 * Transitions are technically effects for video purpose. However in self model transition are handle
 * very different. Regardless of its similar behaviour with the Effect class, Transitions will be the
 * first elements to be applied to the final track. self track need to be composed before any other
 * effect has take place.
 * In addition transitions cannot be layered, they will be always applied before any other effect.
 */
class Transition: EditorElement {
    
    /**
     * Unique effect identifier
     */
    var type:String
    
    /**
     * Media after the transition. When defined it will overwrite afterMedia.opening transition.
     */
    var afterMediaItem:Media
    
    /**
     * Media before the transition. When defined it will overwrite beforeMedia.ending transition.
     */
    var beforeMediaItem:Media
    
    /**
     * The moment the effect is applied since start of the track.
     */
    var startTime:Double
    
    /**
     * Duration of the effect.
     */
    var duration:Double
    
    /**
     * Effect author name.
     */
    var authorName:String
    
    /**
     * Effect author instance if it is a videona user, can be nil if it is not.
     */
    var  author:User
    
    /**
     * License os the effect.
     */
    var license:License
    
    /**
     * Constructor of minimum number of parameters. Default constructor.
     *
     * @param identifier      - Unique identifier of the media for the current project.
     * @param iconPath        - Path to a resource that allows represent the media in the view.
     * @param type            - Opengl unique identifier for transition.
     * @param afterMediaItem  - Media item immediately preceding the transition. If nil the
     *                        transition must be the first item of the editor track, and therefore
     *                        it must be added a void media (blackout 1 sec) during assembly
     *                        proccess.
     * @param beforeMediaItem - Media item immediately following the transition. If nil the
     *                        transition must be the last item of the editor track, and therefore
     *                        it must be added a void media (blackout 1 sec) during assembly
     *                        proccess.
     * @param duration        - transition elapsed time.
     * @param author          - Transition owner's user reference.
     * @param license         - Owner's choice licensing for the transition.
     */
    init(identifier:String ,iconPath:String ,type:String ,afterMediaItem:Media,
         beforeMediaItem:Media,duration:Double, author:User,license:License) {
        self.type = type
        self.afterMediaItem = afterMediaItem
        self.beforeMediaItem = beforeMediaItem
        self.duration = duration
        self.author = author
        self.license = license
        self.startTime = 0.0
        self.authorName = ""
        super.init(identifier: identifier, iconPath: iconPath)
    }
    
    /**
     * @param identifier       - Unique identifier of the media for the current project.
     * @param iconPath         - Path to a resource that allows represent the media in the view.
     * @param selectedIconPath - if not nil used as icon when something interact with the element.
     * @param type             - Opengl unique identifier for transition.
     * @param afterMediaItem   - Media item immediately preceding the transition. If nil the
     *                         transition must be the first item of the editor track, and therefore
     *                         it must be added a void media (blackout 1 sec) during assembly
     *                         proccess.
     * @param beforeMediaItem  - Media item immediately following the transition. If nil the
     *                         transition must be the last item of the editor track, and therefore
     *                         it must be added a void media (blackout 1 sec) during assembly
     *                         proccess.
     * @param duration         - transition elapsed time.
     * @param author           - Transition owner's user reference.
     * @param license          - Owner's choice licensing for the transition.
     */
    init(identifier:String ,iconPath:String ,selectedIconPath:String,type:String ,afterMediaItem:Media,
         beforeMediaItem:Media,duration:Double, author:User,license:License){
        self.type = type
        self.afterMediaItem = afterMediaItem
        self.beforeMediaItem = beforeMediaItem
        self.duration = duration
        self.author = author
        self.license = license
        self.startTime = 0.0
        self.authorName = ""
        
        super.init(identifier: identifier, iconPath: iconPath)
    }
    
    //applying methods
    
    /**
     * self method is called by the editor export functionality when the assembly has been triggered.
     * His functions consist on add the transition between two given media items in the editor track.
     * TODO
     */
    func doTheMagic(){
        
    }
    
    /**
     * self method is called in real time by the editor to show a preview of the current edition
     * track modified by the transition.
     * TODO
     */
    func preview(){
        
    }
    
    
    //getters & setters
    func getType() ->String{
        return type
    }
    
    func setType(type:String) {
        self.type = type
    }
    
    func getDuration() ->Double{
        return duration
    }
    
    func setDuration(duration:Double) {
        self.duration = duration
    }
    
    func getStartTime() ->Double{
        return startTime
    }
    
    func setStartTime(startTime:Double) {
        self.startTime = startTime
    }
    
    func getLicense()->License {
        return license
    }
    
    func setLicense(license:License) {
        self.license = license
    }
    
    func getAuthorName()->String {
        return authorName
    }
    
    func setAuthorName( authorName:String) {
        self.authorName = authorName
    }
    
    func getAuthor() ->User{
        return author
    }
    
    func setAuthor(author:User) {
        self.author = author
    }
    
    func getAfterMediaItem() ->Media{
        return afterMediaItem
    }
    
    func setAfterMediaItem(afterMediaItem:Media) {
        
        //if nil then we are erasing relations between media and transition
        //        if (afterMediaItem == nil && self.afterMediaItem != nil) {
        //            if (self.afterMediaItem.getOpening() != nil) {
        //                self.afterMediaItem.setOpening(nil)
        //            }
        //        }
        
        self.afterMediaItem = afterMediaItem
        
        //after assigned the media, check if opening is self
        //        if (self.afterMediaItem != nil && self.afterMediaItem.getOpening() != self) {
        self.afterMediaItem.setOpening(self)
        //        }
    }
    
    func getBeforeMediaItem()->Media {
        return beforeMediaItem
    }
    
    func setBeforeMediaItem(beforeMediaItem:Media) {
        
        //if nil then we are erasing relations between media and transition
        //        if (beforeMediaItem == nil && self.beforeMediaItem != nil) {
        //            if (self.beforeMediaItem.getEnding() != nil) {
        //                self.beforeMediaItem.setEnding(nil)
        //            }
        //        }
        
        self.beforeMediaItem = beforeMediaItem
        
        //after assigned the media, check if opening is self
        //        if (self.beforeMediaItem != nil && self.beforeMediaItem.getEnding() != self) {
        self.beforeMediaItem.setEnding(self)
        //        }
    }
}
