//
//  FilterListPresentationTransition.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 12/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class FilterListPresentationTransition: NSObject {
    
    func animateTransition(transitionView: UIView, completion: ((Bool) -> Void)?) {
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseOut, animations: {
            var transitionViewTopFrame = transitionView.frame
            transitionViewTopFrame.origin.y += 0
            
            var transitionViewBottomFrame = transitionView.frame
            transitionViewBottomFrame.origin.y -= transitionViewBottomFrame.size.height/2 + 10
            
            transitionView.frame = transitionViewTopFrame
            transitionView.frame = transitionViewBottomFrame
            
            }, completion: { finished in
                print("Transition presentation finished")
        })
    }
    
}