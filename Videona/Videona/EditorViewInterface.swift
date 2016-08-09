//
//  EditorViewInterface.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 21/7/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation
import UIKit

protocol EditorViewInterface {
    func setUpGestureRecognizer()
    func selectCell(indexPath:NSIndexPath)
    func deselectCell(indexPath:NSIndexPath)
    func reloadCollectionViewData()
    func setPositionList(list:[Int])
    func setVideoImagesList(list: [UIImage])
    func numberOfCellsInCollectionView()->Int
}