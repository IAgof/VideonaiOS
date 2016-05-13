//
//  FilterListDismissalTransition.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 12/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class FilterListDismissalTransition :  NSObject {

    func animateTransition(transitionView: UIView, completion: ((Bool) -> Void)?) {
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseOut, animations: {
            var transitionViewTopFrame = transitionView.frame
            transitionViewTopFrame.origin.y -= transitionView.frame.size.height
            
            var transitionViewBottomFrame = transitionView.frame
            transitionViewBottomFrame.origin.y += transitionViewBottomFrame.size.height
            
            transitionView.frame = transitionViewTopFrame
            transitionView.frame = transitionViewBottomFrame
            
            }, completion: { finished in
                print("Transition dismiss finished")
                completion!(true)
        })
    }
}