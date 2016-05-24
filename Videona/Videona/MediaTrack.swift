//
//  MediaTrack.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

/**
 * A media track instance is a track that can contain video and image media items but no audio
 * media items. There could be just one Media track for project.
 *
 * @see com.videonasocialmedia.videona.model.entities.editor.track.Track
 * Created by dfa on 30/3/15.
 */
class MediaTrack : Track {
    
    /**
     * Constructor of minimum number of parameters. Default constructor.
     * Used when a new project is launched.
     *
     * @see com.videonasocialmedia.videona.model.entities.editor.track.Track
     */
    override init(){
        super.init()
    }
    
    /**
     * Parametrized constructor. Used when a saved project is launched.
     *
     * @see com.videonasocialmedia.videona.model.entities.editor.track.Track
     */
    override init(items:Array<Media>,effects:Dictionary<Int, Array<Effect>>,
         transitions:Dictionary<String, Transition>) {
        super.init(items: items, effects: effects, transitions: transitions)
        self.checkItems()
    }
    
    /**
     * Ensure there are only Media items on items list.
     */
    func checkItems() {
        var cont = 0
        for item in items {
            if (item is Audio) {
                //throw new IllegalItemOnMediaTrack("Cannot add media audio items to a media track")
                self.items.removeAtIndex(cont)
            }
            cont += 1
        }
    }
    
    func getNumVideosInProject() ->Int{
        return self.getItems().count
    }
    
    /**
     * Insert a new Media item in the media track. Get sure it is not an Audio media item.
     *
     * @throws IllegalItemOnTrack - when trying to add a Audio item on
     * @see com.videonasocialmedia.videona.model.entities.editor.track.Track
     */
    override func insertItemAt(position:Int, itemToAdd:Media) throws ->Bool{
        if (itemToAdd is Audio) {
            //            throw IllegalItemOnTrack("Cannot add an Audio media item to a MediaTrack.")
        }
        return try super.insertItemAt(position, itemToAdd: itemToAdd)
    }
    
    override func insertItem(itemToAdd:Media) throws ->Bool {
        if (itemToAdd is Audio) {
//            throw IllegalItemOnTrack("Cannot add an Audio media item to a MediaTrack.")
        }
        // With super works, waiting merge model branch to dev return self.insertItem(itemToAdd)
//        let i = items.indexOf({
//            $0.authorsNames[0] == itemToAdd.authorsNames[0]
//        })
        return try super.insertItemAt(0, itemToAdd: itemToAdd)
    }
    
    /**
     * Delete Media item. Get his position and deletes from the list.
     *
     * @param itemToDelete - Media item to be deleted.
     * @return TRUE if the list contained the specified element.
     */
    override func deleteItem(itemToDelete:Media) throws ->Media {
//        let i = items.indexOf({
//            $0.authorsNames[0] == itemToDelete.authors[0]
//        })
        return try self.deleteItemAt(0)
    }
    
    /**
     * Delete Media item on the given position.
     *
     * @param position
     */
    override func deleteItemAt(position:Int) throws ->Media {
        if (self.items[position] is Audio) {
//            throw IllegalItemOnTrack("Cannot add an Audio media item to a MediaTrack.")
        }
        return try super.deleteItemAt(position)
    }
    
    /**
     * Moves Media item to the given position.
     *
     * @param newPosition - The new position in the track for the media item.
     * @param itemToMove  - The media item to ve moved.
     */
    override func moveItemTo(newPosition:Int, itemToMove:Media) throws ->Bool {
        if (itemToMove is Audio) {
//            throw IllegalItemOnTrack("Cannot add an Audio media item to a MediaTrack.")
        }
        return try super.moveItemTo(newPosition, itemToMove: itemToMove)
    }
    
    /**
     * @param items
     */
    override func setItems(items:Array<Media>) {
        super.setItems(items)
        self.checkItems()
    }
    
}