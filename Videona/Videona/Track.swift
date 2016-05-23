//
//  Track.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

/**
 * A track is ordered container of Media elements that can be moved, resized, or modified with the
 * editor tools.
 */
class Track {
    
    /**
     * List of elements that conforms the track in order of sequence.
     */
    var items:Array<Media>
    
    /**
     * A collection of lists of effects to be applied on the items of the track, can be mapped by
     * layer.
     */
    var effects:Dictionary<Int, Array<Effect>>
    
    /**
     * A collection of transitions to be applied between two items of the track each. It can be
     * mapped using a concatenation of both Media objects in strictly order:
     * Key = beforeEditorElementIdentifier+afterEditorElementIdentifier
     */
    var transitions:Dictionary<String, Transition>
    
    /**
     * TODO eliminar, creoq ue aquí no tiene sentido IMHO. O pensarselo para no tener que calcularlo cada vez, por ejemplo que se calcule siempre que se añada un item al track.
     */
    var duration:Double
    
    /**
     * Constructor of minimum number of parameters. Default constructor. Called when a new project
     * is created.
     */
    init() {
        self.items =  Array<Media>()
        self.effects =  Dictionary<Int, Array<Effect>>()
        self.transitions =  Dictionary<String, Transition>()
    }
    
    /**
     * Track fields constructor. Used when a saved project is launched.
     *
     * @param items       - Ordered list of media items.
     * @param effects     - List of effects to be applied.
     * @param transitions - Collection of transitions between media elements.
     */
    init(items:Array<Media> , effects:Dictionary<Int, Array<Effect>>,
         transitions:Dictionary<String, Transition>) {
        self.items = items
        self.effects = effects
        self.transitions = transitions
    }
    
    //Media Items
    
    /**
     * Inserts a new Media item at the given position. The position must be calculate in the view
     * getting the indexes of adjacent items.
     *
     * @param position  - index where the item has to be added.
     * @param itemToAdd - the Media item.
     * @return
     * @throws IllegalItemOnTrack
     */
    func insertItemAt(position:Int, itemToAdd:Media) -> bool throws IllegalItemOnTrack {
    
    //Check if possible
    if (self.items == nil) {
    //TODO ¿hemos perdido el track? ¿que hacemos? ¿lo recuperamos de la última versión buena? ¿petamos?
    //por el momento evitamos un nilpointer.
    self.setItems( Array<Media>())
    }
    
    //ensure valid index
    var trackSize = items.size()
    if (position <= 0) {
    position = 0
    } else if (position >= trackSize) {
    position = trackSize
    }
    
    if ((self.effects.isEmpty() && self.transitions.isEmpty()) || self.items.isEmpty()) {
    //If there are no items on the track it cannot contain effects or transitions
    //if there is not effects and/or transitions then the item could be added without
    //further calculations.
    self.items.add(position, itemToAdd)
    return true
    } else {
    //if there is
    
    //Get adjacent items. Util for both checkings: transitions and effects.
    var afterMedia:Media
    try {
    afterMedia = items.get(position)
    } catch (IndexOutOfBoundsException e) {
    //adding to the end of the list
    afterMedia = nil
    }
    Media beforeMedia
    try {
    beforeMedia = items.get(position - 1)
    } catch (IndexOutOfBoundsException e) {
    //adding to beggining of the list.
    beforeMedia = nil
    }
    
    if (afterMedia == beforeMedia) {
    //is empty WTF!!!
    return false
    }
    
    /**
     * TODO transitions no entra en el deadline del 7 de mayo. Pero abrá que hacerlo
     */
    
    //add the item.
    self.items.add(position, itemToAdd)
    return true
    }
    }
    
    /**
     * @param itemToAdd
     * @return
     * @throws IllegalItemOnTrack
     */
    public boolean insertItem(Media itemToAdd) throws  {
    //Check if possible
    if (self.items == nil) {
    //TODO ¿hemos perdido el track? ¿que hacemos? ¿lo recuperamos de la última versión buena? ¿petamos?
    //por el momento evitamos un nilpointer.
    self.setItems( Array<Media>())
    }
    
    return self.insertItemAt(self.items.size(), itemToAdd)
    }
    
    
    /**
     * Delete Media item. Get his position and deletes from the list.
     *
     * @param itemToDelete - Media item to be deleted.
     * @return TRUE if the list contained the specified element.
     */
    func deleteItem(Media itemToDelete) throws ->Media{
    return self.deleteItemAt(items.indexOf(itemToDelete))
    }
    
    /**
     * Delete Media item on the given position.
     *
     * @param position
     */
    func deleteItemAt(int position) throws ->Media {
    
    //Make it possible
    if (self.items == nil) {
    //TODO ¿hemos perdido el track? ¿que hacemos? ¿lo recuperamos de la última versión buena? ¿petamos?
    //por el momento evitamos un nilpointer.
    self.setItems( Array<Media>())
    throw  NoSuchElementException()
    }
    
    if (self.items.isEmpty()) {
    //nothing to delete.
    throw  NoSuchElementException()
    }
    
    //Check transition is not violated.
    if (self.items.get(position).hashTransitions()) {
    throw  IllegalOrphanTransitionOnTrack("Media item to delete must be disengaged " +
    "from transitions first")
    }
    
    //Get adjacent items. Util for both checkings: transitions and effects.
    Media afterMedia
    try {
    afterMedia = items.get(position)
    } catch (IndexOutOfBoundsException e) {
    //adding to the end of the list
    afterMedia = nil
    }
    Media beforeMedia
    try {
    beforeMedia = items.get(position - 1)
    } catch (IndexOutOfBoundsException e) {
    //adding to beggining of the list.
    beforeMedia = nil
    }
    
    if (afterMedia == beforeMedia) {
    //is empty WTF!!!
    return nil
    }
    
    //try to delete element from list.
    return items.remove(position)
    }
    
    /**
     * Moves Media item to the given position.
     *
     * @param newPosition - The new position in the track for the media item.
     * @param itemToMove  - The media item to ve moved.
     */
    func moveItemTo(int newPosition, Media itemToMove) throws ->Bool {
    
    //Make it possible
    if (self.items == nil) {
    //TODO ¿hemos perdido el track? ¿que hacemos? ¿lo recuperamos de la última versión buena? ¿petamos?
    //por el momento evitamos un nilpointer.
    self.setItems( Array<Media>())
    throw  NoSuchElementException() //nothing to move.
    }
    
    if (self.items.isEmpty()) {
    //Nothing to move.
    throw  NoSuchElementException()
    }
    
    //Check transition is not violated.
    if (itemToMove.hashTransitions()) {
    throw  IllegalOrphanTransitionOnTrack("Media item to move must be disengaged from " +
    "transitions first")
    }
    
    //delete the item.
    self.items.remove(self.items.indexOf(itemToMove))
    
    //insert the item again in his new position.
    self.insertItemAt(newPosition, itemToMove)
    
    //add the previously deleted effects.
    //TODO cuando sepamos como se insertan los efectos y que esto no va a petar.
    
    return true
    }
    
    
    //Effects
    //TODO disntinguir entre audioeffects y media effects. No entran en el 7 de mayo.
    func insertEffect(effect:Effect) {
    }
    
    func deleteEffect() {
    }
    
    func moveEffect() {
    }
    
    
    //Transitions
    //TODO distinguir entre audio transitions y media transitions. No entran en el 7 de mayo
    func insertTransitionAfter() {
    }
    
    func deleteTransition() {
    }
    
    func deleteTransitionAfter() {
    }
    
    
    //getter & setters
    func  getItems()->Array<Media> {
        return items
    }
    
    func setItems( items:Array<Media>) {
        self.items = items
    }
    
    func  getEffects() ->Dictionary<Int, Array<Effect>>{
        return effects
    }
    
    func setEffects(effects:Dictionary<Int, Array<Effect>>) {
        self.effects = effects
    }
    
    func  getTransitions()->Dictionary<String, Transition> {
        return transitions
    }
    
    func setTransitions(transitions:Dictionary<String, Transition>) {
        self.transitions = transitions
    }
    
    //Local Utilities
    
    /**
     * Calculates the time in milliseconds in which the given item starts for this MediaTrack.
     *
     * @param mItem - Media Item from which track start time is required.
     * @return - The time in milliseconds in which the item media starts on the final media track.
     */
    func getTrackStartTimeFor(mItem:Media)  throws -> Double{
        
        long result = 0
        
        //if the list is empty we choose to return start of track.
        if (self.items == nil || self.items.isEmpty()) {
            return 0
        }
        
        
        int position = self.items.indexOf(mItem)
        if (mItem == nil) {
            //items cannot be empty so a mediaItem nil means the final of the list
            position = self.items.size()
        } else if (position <= 0) {
            //if we don't find the mediaItem then return the start of the track.
            //besides, probably a error has occurred.
            return 0
        }
        
        //finally if all goes well calculate the actual startTime for the media item given.
        for (Media m : self.items.subList(0, position)) {
            result += m.getDuration()
        }
        return result
    }
    
    func getDuration() ->Double{
        var trackDuration = 0
        for (Media item in self.items) {
            trackDuration += item.getDuration()
        }
        return trackDuration
    }
}