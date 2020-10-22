//
//  FullImageViewController.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper

protocol FullImageViewInput: ViperViewInput { }

protocol FullImageViewOutput: ViperViewOutput { }

class FullImageViewController: ViperViewController, FullImageViewInput {

    // MARK: - Outlets
    @IBOutlet private weak var photoImageView: UIImageView!
    
    // MARK: - Props
    fileprivate var output: FullImageViewOutput? {
        guard let output = self._output as? FullImageViewOutput else { return nil }
        return output
    }
    
    // MARK: - Lifecycle
    override func viewWillLayoutSubviews() {
        self.applyStyles()
    }
    
    // MARK: - Setup functions
    func setupComponents() {
        self.navigationItem.title = ""
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupActions() { }
    
    func applyStyles() { }
    
    // MARK: - FullImageViewInput
    override func setupInitialState(with viewModel: ViperViewModel) {
        super.setupInitialState(with: viewModel)
        
        self.setupComponents()
        self.setupActions()
    }
    
}

// MARK: - Actions
extension FullImageViewController { }

// MARK: - Module functions
extension FullImageViewController { }
