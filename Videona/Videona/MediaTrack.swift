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
    init(items:LinkedList<Media>,effects:Dictionary<Integer, LinkedList<Effect>>,
         transitions:Dictionary<String, Transition>) ->MediaTrack{
        super(items, effects, transitions)
        self.checkItems()
    }
    
    /**
     * Ensure there are only Media items on items list.
     */
    func checkItems() {
        for (Media item in items) {
            if (item is Audio) {
                //throw new IllegalItemOnMediaTrack("Cannot add media audio items to a media track")
                self.items.removeFirstOccurrence(item)
            }
        }
    }
    
    func getNumVideosInProject() ->Int{
        return self.getItems().size()
    }
    
    /**
     * Insert a new Media item in the media track. Get sure it is not an Audio media item.
     *
     * @throws IllegalItemOnTrack - when trying to add a Audio item on
     * @see com.videonasocialmedia.videona.model.entities.editor.track.Track
     */
    override func insertItemAt(position:Int, itemToAdd:Media) throws ->Bool{
        if (itemToAdd is Audio) {
            throw IllegalItemOnTrack("Cannot add an Audio media item to a MediaTrack.")
        }
        return super.insertItemAt(position, itemToAdd)
    }
    
    override func insertItem(itemToAdd:Media) throws ->Bool {
        if (itemToAdd is Audio) {
            throw IllegalItemOnTrack("Cannot add an Audio media item to a MediaTrack.")
        }
        // With super works, waiting merge model branch to dev return self.insertItem(itemToAdd)
        return super.insertItem(itemToAdd)
    }
    
    /**
     * Delete Media item. Get his position and deletes from the list.
     *
     * @param itemToDelete - Media item to be deleted.
     * @return TRUE if the list contained the specified element.
     */
    func deleteItem(itemToDelete:Media) throws ->Media {
        return self.deleteItemAt(self.items.indexOf(itemToDelete))
    }
    
    /**
     * Delete Media item on the given position.
     *
     * @param position
     */
    func deleteItemAt(int position) throws ->Media {
        if (self.items.get(position) is Audio) {
            throw IllegalItemOnTrack("Cannot add an Audio media item to a MediaTrack.")
        }
        return super.deleteItemAt(position)
    }
    
    /**
     * Moves Media item to the given position.
     *
     * @param newPosition - The new position in the track for the media item.
     * @param itemToMove  - The media item to ve moved.
     */
    func moveItemTo(newPosition:Int, itemToMove:Media) throws ->Media {
        if (itemToMove is Audio) {
            throw IllegalItemOnTrack("Cannot add an Audio media item to a MediaTrack.")
        }
        return super.moveItemTo(newPosition, itemToMove)
    }
    
    /**
     * @param items
     */
    func setItems(items:Array<Media>) {
        super.setItems(items)
        self.checkItems()
    }
    
}