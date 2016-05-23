//
//  License.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 23/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
/**
 * First implementation of licensing for media used in videona. self need to be revised and probably
 * replaced by supported classes of android development community like DRM or something.
 * <p/>
 * Created by dfa on 8/4/15.
 */
class License {
    
    /**
     * The license text.
     */
    var text:String
    
    /**
     * The license reference name.
     */
    var name:String


    init(text:String, name:String) {
    self.text = text;
    self.name = name;
    }
    
    func getText() ->String{
    return text;
    }
    
    func setText(text:String) {
    self.text = text;
    }
    
    func getName()->String {
    return name;
    }
    
    func setName(name:String) {
        self.name = name;
    }
    
    let CC40_NAME = "CC BY-NC-SA 4.0";
    let CC40_TEXT = "Summary\n" +
    "Creative Commons Attribution-NoDeratives license in International version 4, that " +
    "allows to do what they want except modifying.\n Attribution\n You must give credit to " +
    "the original author of the work, including a URI or hyperlink to the work, self Public" +
    " license and a copyright notice.\n\nAttribution information revoke\n\nAuthor can " +
    "request to remove any attribution given information.\n\nTivoization\nYou may not apply " +
    "legal terms or technological measures that legally restrict others from doing anything " +
    "the license permits.\n\nDisclaimer of warranties\nDisclaimer of warranties is optional." +
    "\n\nIf separately undertaken, shared material must retain a notice to Disclaimer of " +
    "warranties.\n\nOtherwise, Disclaimer of warranties, is taken by default, providing the " +
    "work as-is and as-available.\n\nLiable\nLiable follows the same rules as Disclaimer of " +
    "warranties, providing, by default, protection from defamation for the creator.\n\n" +
    "Revoke\n The licensor cannot revoke these freedoms as long as you follow the license " +
    "terms.";
}
