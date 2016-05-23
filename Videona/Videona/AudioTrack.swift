//
//  AudioTrack.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

/**
 * An audio track is a track that can only contain Audio media items. There could be many audio
 * tracks in a project.
 * <p/>
 * Created by dfa on 30/3/15.
 */
class AudioTrack:Track {
    
    /**
     * Constructor of minimum number of parameters. Default constructor. Used when a new project
     * is launched.
     *
     * @see com.videonasocialmedia.videona.model.entities.editor.track.Track
     */
    init() {
        super()
    }
    
    /**
     * Parametrized constructor. Used when a saved project is launched.
     *
     * @see com.videonasocialmedia.videona.model.entities.editor.track.Track
     */
    init(items:Array<Media> ,  effects:Dictionary<Int, Array<Effect>>,
     transitionsDictionary<String, Transition>) -> AudioTrack{
        super(items, effects, transitions)
        self.checkItems()
    }
    
    /**
     * Ensure there are only Audio items on items list.
     */
     func checkItems() {
        for (Object item in self.getItems()) {
            if (!(item is Audio)) {
                self.items.removeFirstOccurrence(item)
            }
        }
    }
    
    /**
     * Insert a new Audio item in the AudioTrack. Get sure it is an Audio media item.
     *
     * @throws IllegalItemOnTrack - when trying to add a Audio item on
     * @see com.videonasocialmedia.videona.model.entities.editor.track.Track
     */
     
    override func insertItemAt(position:Int, itemToAdd:Media) throws->Bool {
        if (!(itemToAdd is Audio)) {
            throw IllegalItemOnTrack("Audio track can only have audio media items.")
        }
        return super.insertItemAt(position, itemToAdd)
    }
    
     func insertItem(itemToAdd:Media) throws ->Bool {
        if (!(itemToAdd is Audio)) {
            throw IllegalItemOnTrack("Audio track can only have audio media items.")
        }
        return super.insertItem(itemToAdd)
    }
    
    /**
     * Delete Media item. Get his position and deletes from the list.
     *
     * @param itemToDelete - Media item to be deleted.
     * @return TRUE if the list contained the specified element.
     */
     func deleteItem(itemToDelete:Media) throws ->Media{
        return super.deleteItemAt(self.items.indexOf(itemToDelete))
    }
    
    /**
     * Delete Media item on the given position.
     *
     * @param position
     */
     func deleteItemAt(int position) throws ->Media {
        if (!(self.items.get(position) is Audio)) {
            throw IllegalItemOnTrack("Audio track can only have audio media items.")
        }
        return super.deleteItemAt(position)
    }
    
    /**
     * Moves Media item to the given position.
     *
     * @param newPosition - The new position in the track for the media item.
     * @param itemToMove  - The media item to ve moved.
     */
     func moveItemTo(newPosition:Int, itemToMove:Media) throws ->Bool
     {
        if (!(itemToMove is Audio)) {
            throw IllegalItemOnTrack("Audio track can only have audio media items.")
        }
        return super.moveItemTo(newPosition, itemToMove)
    }
    
     func  setItems(items:Array<Media> ) {
        super.setItems(items)
        self.checkItems()
    }
}
