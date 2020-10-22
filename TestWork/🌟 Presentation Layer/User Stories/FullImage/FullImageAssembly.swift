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
        return FullImageViewController(nibName: FullImageViewController.identifier, bundle: nil)
    }
    
    static func configure(with reference: FullImageViewController) -> FullImagePresenterInput {
        let presenter = FullImagePresenter()
        
        let router = FullImageRouter()
        router._mainController = reference
        
        presenter._view = reference
        presenter._router = router
        
        reference._output = presenter
        
        return presenter
    }
    
}
