//
//  SavedFullImageRouter.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 26.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper

protocol SavedFullImageRouterInput: ViperRouterInput { }

class SavedFullImageRouter: ViperRouter, SavedFullImageRouterInput {
    
    // MARK: - Props
    fileprivate var mainController: SavedFullImageViewController? {
        guard let mainController = self._mainController as? SavedFullImageViewController else {
            return nil
        }
        return mainController
    }
    
    // MARK: - SavedFullImageRouterInput
    
    // MARK: - Module functions
}
