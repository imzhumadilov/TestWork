//
//  SavedPhotosRouter.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 26.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper

protocol SavedPhotosRouterInput: ViperRouterInput {
    func pushFullImageVC(with imageData: Data)
}

class SavedPhotosRouter: ViperRouter, SavedPhotosRouterInput {
    
    // MARK: - Props
    fileprivate var mainController: SavedPhotosViewController? {
        guard let mainController = self._mainController as? SavedPhotosViewController else {
            return nil
        }
        return mainController
    }
    
    // MARK: - SavedPhotosRouterInput
    func pushFullImageVC(with imageData: Data) {
        let vc = SavedFullImageAssembly.create()
        SavedFullImageAssembly.configure(with: vc, imageData: imageData)
        
        mainController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Module functions
}
