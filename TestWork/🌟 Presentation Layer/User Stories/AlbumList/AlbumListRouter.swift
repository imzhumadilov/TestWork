//
//  AlbumListRouter.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper

protocol AlbumListRouterInput: ViperRouterInput {
    func pushPhotosListVC(with album: Album)
}

class AlbumListRouter: ViperRouter, AlbumListRouterInput {
    
    // MARK: - Props
    fileprivate var mainController: AlbumListViewController? {
        guard let mainController = self._mainController as? AlbumListViewController else {
            return nil
        }
        return mainController
    }
    
    // MARK: - AlbumListRouterInput
    func pushPhotosListVC(with album: Album) {
        let vc = PhotosListAssembly.create()
        PhotosListAssembly.configure(with: vc, album: album)
        
        mainController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Module functions
}
