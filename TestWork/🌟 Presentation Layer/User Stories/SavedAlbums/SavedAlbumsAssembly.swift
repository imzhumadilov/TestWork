//
//  SavedAlbumsAssembly.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 26.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper

enum SavedAlbumsAssembly {
    
    static func create() -> SavedAlbumsViewController {
        return SavedAlbumsViewController(nibName: SavedAlbumsViewController.identifier, bundle: nil)
    }
    
    @discardableResult
    static func configure(with reference: SavedAlbumsViewController) -> SavedAlbumsPresenterInput {
        let presenter = SavedAlbumsPresenter()
        
        let router = SavedAlbumsRouter()
        router._mainController = reference
        
        presenter._view = reference
        presenter._router = router
        
        reference._output = presenter
        
        return presenter
    }
    
}
