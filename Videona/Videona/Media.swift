//
//  Media.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

/**
 * Abstract representation of any media resource that can be used in the project.
 * TODO habrá que echar un vistazo a esto http://developer.android.com/reference/android/media/package-summary.html
 *
 * @author Juan Javier Cabanas
 * @author Álvaro Martínez Marco
 * @author Danny R. Fonseca Arboleda
 */

class Media: EditorElement {
    
    /**
     * Title of the media. Should be the video name in the social network
     */
    var title:String
    
    /**
     * The path of the media resource
     */
    var mediaPath:String
    
    var source:NSData
    
    /**
     * The start time of the media resource within the file it represents.
     */
    var fileStartTime:Double
    
    /**
     * The start time of the media resource within the file it represents.
     */
    var fileStopTime:Double
    
    /**
     * @deprecated
     * It's not necessary to set self param. In getter calculates the difference between stop time
     * and start time
     *
     * The long of the media resource to be added to the project
     */
    var duration:Double
    
    /**
     * Transition before the media item.
     */
    var opening:Transition?
    
    /**
     * Transition after the media item.
     */
    var ending:Transition?
    
    /**
     * Metadata of the resource
     */
    var metadata:NSMetadataItem?
    
    /**
     * List with de authors id
     */
    var authors:Array<User>
    
    /**
     * List with de authors names. Used when at least one author is not a videona user.
     */
    var authorsNames:Array<String>
    
    /**
     * License of the media file.
     */
    var license:License
    
    /**
     * Constructor of minimum number of parameters. Default constructor.
     *
     * @param identifier    - Unique identifier of the media for the current project.
     * @param iconPath      - Path to a resource that allows represent the media in the view.
     * @param mediaPath     - Path to the resource file that self media represents.
     * @param fileStartTime - Media item initial time in milliseconds within the file referenced
     * @param duration      - Media item duration in milliseconds within the file referenced
     * @param license       - Legal stuff.
     * @param authors       - List of authors of the media item.
     */
    init(identifier:String,iconPath:String, mediaPath:String,fileStartTime:Double,duration:Double,authors:Array<User>,license:License){
        self.title = ""
        self.mediaPath = mediaPath
        self.source = NSData.init(contentsOfFile: self.mediaPath)!
        self.fileStartTime = fileStartTime
        self.fileStopTime = duration
        self.duration = duration
        self.opening = nil
        self.ending = nil
        self.metadata = nil
        self.authors = authors
        self.license = license
        self.authorsNames = Array<String>()
        
        super.init(identifier: identifier, iconPath: iconPath)
    }
    
    /**
     * Parametrized constructor. It requires all possible attributes for an effect object.
     *
     * @param identifier       - Unique identifier of the media for the current project.
     * @param iconPath         - Path to a resource that allows represent the media in the view.
     * @param selectedIconPath - if not nil used as icon when something interact with the element.
     *                         If nil it will be used the iconPath as default.
     * @param title            - Human friendly title for the media item.
     * @param mediaPath        - Path to the resource file that self media represents.
     * @param fileStartTime    - Media item initial time in milliseconds within the file referenced
     * @param duration         - Media item duration in milliseconds within the file referenced
     * @param opening          - reference to a transition after the media item in the track.
     * @param ending           - reference to a transition before the media item in the track.
     * @param metadata         - File metadata.
     * @param license          - Legal stuff.
     * @param authors          - List of authors of the media item.
     */
    init(identifier:String,iconPath:String, selectedIconPath:String, title:String, mediaPath:String,fileStartTime:Double,duration:Double,opening:Transition,ending:Transition,metadata:NSMetadataItem,authors:Array<User>,license:License){
        
        self.title = title
        self.mediaPath = mediaPath
        self.source = NSData.init(contentsOfFile: self.mediaPath)!
        self.fileStartTime = fileStartTime
        self.fileStopTime = duration
        self.duration = duration
        self.opening = opening
        self.ending = ending
        self.metadata = metadata
        self.authors = authors
        self.license = license
        self.authorsNames = Array<String>()
        
        super.init(identifier: identifier, iconPath: iconPath, selectedIconPath: selectedIconPath)
    }
    
    func hashTransitions() ->Bool{
        //        return (self.opening != nil || self.ending != nil)
        return true
    }
    
    
    //getters & setters
    func getTitle() ->String{
        return title
    }
    
    func setTitle(title:String) {
        self.title = title
    }
    
    func getMediaPath() ->String{
        return mediaPath
    }
    
    func setMediaPath(mediaPath:String) {
        self.mediaPath = mediaPath
    }
    
    func getFileStartTime() ->Double {
        return self.fileStartTime
    }
    
    func setFileStartTime(fileStartTime:Double) {
        self.fileStartTime = fileStartTime
    }
    
    func getDuration() ->Double {
        return fileStopTime - fileStartTime
    }
    
    /**
     * @deprecated
     * @param duration
     */
    func setDuration(duration:Double) {
        self.duration = duration
    }
    
    func getFileStopTime()  ->Double{
        return fileStopTime
    }
    
    func setFileStopTime(fileStopTime:Double) {
        self.fileStopTime = fileStopTime
    }
    
    func getMetadata() ->NSMetadataItem {
        if let metadata = self.metadata{
         return metadata
        }else{
            return NSMetadataItem.init()
        }
    }
    
    func setMetadata(metadata:NSMetadataItem) {
        self.metadata = metadata
    }
    
    func  getAuthors() ->Array<User> {
        return authors
    }
    
    func setAuthors(authors:Array<User> ) {
        self.authors = authors
    }
    
    func  getAuthorsNames() ->Array<String> {
        return authorsNames
    }
    
    func setAuthorsNames(authorsNames:Array<String>) {
        self.authorsNames = authorsNames
    }
    
    func getLicense() ->License {
        return license
    }
    
    func setLicense(license:License) {
        self.license = license
    }
    
    func  getOpening() ->Transition {
        if let opening = self.opening{
            return opening
        }else{
            return opening!
        }
    }
    
    func setOpening( opening:Transition) {
        
        //if nil then we are erasing relations between media and transition
        
        //        self.opening.setAfterMediaItem(nil)
        //
        //        self.opening = opening
        //
        //        //check that afterMediaItem of transition is self.
        //        if (self.opening.getAfterMediaItem() != self) {
        //            self.opening.setAfterMediaItem(self)
        //        }
    }
    
    func  getEnding() ->Transition {
        if let ending = self.ending{
            return ending
        }else{
            return ending!
        }
    }
    
    func setEnding(ending:Transition) {
        
        //        //if nil then we are erasing relations between media and transition
        //            if (self.ending.getBeforeMediaItem() != nil) {
        //                self.ending.setBeforeMediaItem(nil)
        //            }
        //
        //        self.ending = ending
        //
        //        //check that beforerMediaItem of transition is self.
        //        if (self.ending != nil && self.ending.getBeforeMediaItem() != self) {
        //            self.opening.setBeforeMediaItem(self)
        //        }
    }
}
