//
//  SettingsPresenter.swift
//  Videona
//
//  Created by Alejandro Arjonilla Garcia on 11/5/16.
//  Copyright © 2016 Videona. All rights reserved.
//

import Foundation

class SettingsPresenter:NSObject,SettingsPresenterInterface{
    
    var wireframe: SettingsWireframe?
    var controller: SettingsInterface?
    var recordWireframe: RecordWireframe?
    var interactor: SettingsInteractor?
   
    func pushBack() {
        print("Navigator presenter pushEdit")
        let recordViewController = recordWireframe?.RecordViewControllerFromStoryboard()
        
        controller?.navigateToNewViewController(recordViewController!)
    }
    func viewDidLoad() {
        controller?.createNavigationBar()
        controller?.registerClass()
        self.getListData()
    }
    
    func getListData (){
        let settings = interactor?.findSettings()
        
        self.setListTitleData((settings?.1)!)
        self.setSectionListData((settings?.0)!)
    }
    
    func setListTitleData(titleArray:Array<Array<String>>){
        controller?.setTitleList(titleArray)
    }
    
    func setSectionListData(section:Array<String>){
        controller?.setSectionList(section)
    }
}