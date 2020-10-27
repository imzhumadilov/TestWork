//
//  FullImageAssembly.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper

enum FullImageAssembly {
    
    static func create() -> FullImageViewController {
        FullImageViewController(nibName: FullImageViewController.identifier, bundle: nil)
    }
    
    @discardableResult
    static func configure(with reference: FullImageViewController, imageUrl: String) -> FullImagePresenterInput {
        let presenter = FullImagePresenter(imageUrl: imageUrl)
        
        let router = FullImageRouter()
        router._mainController = reference
        
        presenter._view = reference
        presenter._router = router
        
        reference._output = presenter
        
        return presenter
    }
    
}
