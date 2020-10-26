//
//  SavedFullImageAssembly.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 26.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper

enum SavedFullImageAssembly {
    
    static func create() -> SavedFullImageViewController {
        return SavedFullImageViewController(nibName: SavedFullImageViewController.identifier, bundle: nil)
    }
    
    @discardableResult
    static func configure(with reference: SavedFullImageViewController, imageData: Data) -> SavedFullImagePresenterInput {
        let presenter = SavedFullImagePresenter(imageData: imageData)
        
        let router = SavedFullImageRouter()
        router._mainController = reference
        
        presenter._view = reference
        presenter._router = router
        
        reference._output = presenter
        
        return presenter
    }
    
}
