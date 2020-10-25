//
//  PhotosListAssembly.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper

enum PhotosListAssembly {
    
    static func create() -> PhotosListViewController {
        return PhotosListViewController(nibName: PhotosListViewController.identifier, bundle: nil)
    }
    
    @discardableResult
    static func configure(with reference: PhotosListViewController, album: Album) -> PhotosListPresenterInput {
        let presenter = PhotosListPresenter(album: album)
        
        let router = PhotosListRouter()
        router._mainController = reference
        
        presenter._view = reference
        presenter._router = router
        
        reference._output = presenter
        
        return presenter
    }
    
}
