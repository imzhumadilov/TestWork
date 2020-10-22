//
//  InitialRouter.swift
//  Arcana
//
//  Created by  Кирилл on 10/26/19.
//  Copyright © 2019 AppCraft. All rights reserved.
//

import GKViper

protocol InitialRouterInput: ViperRouterInput {
    func pushPhotosListVC(with album: Album)
}

class InitialRouter: ViperRouter, InitialRouterInput {
    
    // MARK: - Props
    fileprivate var mainController: InitialViewController? {
        guard let mainController = self._mainController as? InitialViewController else {
            return nil
        }
        return mainController
    }
    
    // MARK: - InitialRouterInput
    func pushPhotosListVC(with album: Album) {
        let vc = PhotosListAssembly.create()
        let input = PhotosListAssembly.configure(with: vc)
        input.configure(with: album)
        
        mainController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentMainViewController() {
//        let vc = MainAssembly.create()
//        _ = MainAssembly.configure(with: vc)
//
//        vc.modalPresentationStyle = .fullScreen
//
//        self.present(vc, animated: false)
    }
    
    // MARK: - Module functions
}
