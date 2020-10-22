//
//  FullImageRouter.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper

protocol FullImageRouterInput: ViperRouterInput { }

class FullImageRouter: ViperRouter, FullImageRouterInput {
    
    // MARK: - Props
    fileprivate var mainController: FullImageViewController? {
        guard let mainController = self._mainController as? FullImageViewController else {
            return nil
        }
        return mainController
    }
    
    // MARK: - FullImageRouterInput
    
    // MARK: - Module functions
}
