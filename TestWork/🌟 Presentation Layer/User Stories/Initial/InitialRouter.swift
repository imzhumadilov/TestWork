//
//  InitialRouter.swift
//  Arcana
//
//  Created by  Кирилл on 10/26/19.
//  Copyright © 2019 AppCraft. All rights reserved.
//

import GKViper

protocol InitialRouterInput: ViperRouterInput {
    func showAlbumsListVC()
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
    func showAlbumsListVC() {
        let vc = AlbumListAssembly.create()
        AlbumListAssembly.configure(with: vc)
        let nc = UINavigationController(rootViewController: vc)
        
        nc.modalPresentationStyle = .overFullScreen
        mainController?.present(nc, animated: true)
        
//        mainController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Module functions
}
