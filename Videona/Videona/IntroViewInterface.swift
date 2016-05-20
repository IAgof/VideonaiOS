//
//  IntroViewInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 4/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

protocol IntroViewInterface {
    func goToNextView()
    func changeNextFinishButtonTitle(title:String)
    func updateCurrentPage(page:Int)
}