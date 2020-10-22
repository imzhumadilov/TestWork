//
//  AlbumListAssembly.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper

enum AlbumListAssembly {
    
    static func create() -> AlbumListViewController {
        return AlbumListViewController(nibName: AlbumListViewController.identifier, bundle: nil)
    }
    
    static func configure(with reference: AlbumListViewController) -> AlbumListPresenterInput {
        let presenter = AlbumListPresenter()
        
        let router = AlbumListRouter()
        router._mainController = reference
        
        presenter._view = reference
        presenter._router = router
        
        reference._output = presenter
        
        return presenter
    }
    
}
