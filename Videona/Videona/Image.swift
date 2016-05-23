//
//  Image.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation


/**
 * A media image item that represents a file that can be used in project video track.
 *
 * @see com.videonasocialmedia.videona.model.entities.editor.media.Media
 */
class Image:Media {
    
    let DEFAULT_IMAGE_DURATION = 3;
    var IMAGE_PATH = "";
    
    
    /**
     * Constructor of minimum number of parameters. Default constructor.
     * <p/>
     * An image always starts at the beginning of the file and has a default duration fixed for
     * recent created image objects. However this duration could be changed during the edition
     * process, but the fileStartTime never could be changed.
     *
     * @see com.videonasocialmedia.videona.model.entities.editor.media.Media
     */
    init(identifier:String,iconPath:String, mediaPath:String,authors:Array<User>,license:License){
        super.init(identifier, iconPath, mediaPath, 0, Image.DEFAULT_IMAGE_DURATION, authors, license);
    }
    
    /**
     * Lazy constructor. Creating a image media item from the mediaPath only.
     *
     * @param mediaPath
     */
    init(mediaPath:String) {
        super.init(null, null, mediaPath, 0, Image.DEFAULT_IMAGE_DURATION, null, null);
        //check if the mediapath is an image.
        
        //get the iconpath
        
        //resolve lincese by default.
        self.setLicense(new License(License.CC40_NAME, License.CC40_TEXT));
        
    }
    
    /**
     * Parametrized constructor. It requires all possible attributes for an effect object.
     *
     * @see com.videonasocialmedia.videona.model.entities.editor.media.Media
     */
    init(identifier:String,iconPath:String, selectedIconPath:String, title:String, mediaPath:String,duration:Int,opening:Transition,ending:Transition,metadata:NSMetadataItem,authors:Array<User>,license:License){
        super.init(identifier, iconPath, selectedIconPath, title, mediaPath, 0, duration,
        opening, ending, metadata, authors, license);
    }
    
    func getFileStartTime()->Int {
        return 0;
    }
    
    func setFileStartTime(fileStartTime:Int) {
        //
    }
    
    //utils
    func isImage(File file) ->Bool{
        if (file == nil || !file.exists()) {
            return false;
        }
        BitmapFactory.Options options = BitmapFactory.Options();
        options.inJustDecodeBounds = true;
        BitmapFactory.decodeFile(file.getPath(), options);
        return options.outWidth != -1 && options.outHeight != -1;
    }
}
