//
//  SavedPhotosAssembly.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 26.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper

enum SavedPhotosAssembly {
    
    static func create() -> SavedPhotosViewController {
        return SavedPhotosViewController(nibName: SavedPhotosViewController.identifier, bundle: nil)
    }
    
    @discardableResult
    static func configure(with reference: SavedPhotosViewController, albumId: String) -> SavedPhotosPresenterInput {
        let presenter = SavedPhotosPresenter(albumId: albumId)
        
        let router = SavedPhotosRouter()
        router._mainController = reference
        
        presenter._view = reference
        presenter._router = router
        
        reference._output = presenter
        
        return presenter
    }
    
}
