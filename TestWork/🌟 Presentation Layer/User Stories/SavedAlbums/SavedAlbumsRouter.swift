//
//  SavedAlbumsRouter.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 26.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper

protocol SavedAlbumsRouterInput: ViperRouterInput {
    func pushPhotosListVC(with albumId: String)
}

class SavedAlbumsRouter: ViperRouter, SavedAlbumsRouterInput {
    
    // MARK: - Props
    fileprivate var mainController: SavedAlbumsViewController? {
        guard let mainController = self._mainController as? SavedAlbumsViewController else {
            return nil
        }
        return mainController
    }
    
    // MARK: - SavedAlbumsRouterInput
    func pushPhotosListVC(with albumId: String) {
        let vc = SavedPhotosAssembly.create()
        SavedPhotosAssembly.configure(with: vc, albumId: albumId)

        mainController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Module functions
}
