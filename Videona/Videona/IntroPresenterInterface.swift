//
//  IntroPresenterInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 4/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

protocol IntroPresenterInterface {
    func pushNext(buttonTitle:String)
    func pushSkip()
    func onPageChange(numPage: Int, size: Int)
    func viewDidLoad()
}