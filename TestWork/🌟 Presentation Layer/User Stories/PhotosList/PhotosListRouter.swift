//
//  PhotosListRouter.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper

protocol PhotosListRouterInput: ViperRouterInput {
    func pushFullImageVC(with imageUrl: String)
}

class PhotosListRouter: ViperRouter, PhotosListRouterInput {
    
    // MARK: - Props
    fileprivate var mainController: PhotosListViewController? {
        guard let mainController = self._mainController as? PhotosListViewController else {
            return nil
        }
        return mainController
    }
    
    // MARK: - PhotosListRouterInput
    func pushFullImageVC(with imageUrl: String) {
        let vc = FullImageAssembly.create()
        let input = FullImageAssembly.configure(with: vc)
        input.configure(with: imageUrl)
        
        mainController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Module functions
}
