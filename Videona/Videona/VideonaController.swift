//
//  VideonaController.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 24/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

class VideonaController: UIViewController {

    override func viewDidLoad() {
        print("View did load in \n \(self)")
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("View will dissappear in \n \(self)")
    }
    
    func createAlertInformation(title:String,message:String,buttonText:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: buttonText, style: .Default, handler: { action in
            alert.dismissViewControllerAnimated(true, completion:nil)
        })
        
        alert.addAction(action)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
