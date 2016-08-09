//
//  SplitPresenterInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 4/8/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

protocol SplitPresenterInterface{
    func viewDidLoad()
    func viewWillDissappear()
    func pushCancelHandler()
    func pushAcceptHandler()
    func pushBack()
    func setSplitValue(value:Float)
    func updateSplitValueByPlayer(value:Float)
}

protocol SplitPresenterDelegate {
    func setSplitValueText(text:String)
}
