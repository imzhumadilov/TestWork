//
//  SavedFullImageViewController.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 26.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper

protocol SavedFullImageViewInput: ViperViewInput {
    func setupImage(with imageData: Data)
}

protocol SavedFullImageViewOutput: ViperViewOutput { }

class SavedFullImageViewController: ViperViewController, SavedFullImageViewInput {

    // MARK: - Outlets
    @IBOutlet private weak var photoImageView: UIImageView!
    
    // MARK: - Props
    fileprivate var output: SavedFullImageViewOutput? {
        guard let output = self._output as? SavedFullImageViewOutput else { return nil }
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
        
        photoImageView.image = nil
    }
    
    func setupActions() { }
    
    func applyStyles() { }
    
    // MARK: - SavedFullImageViewInput
    override func setupInitialState(with viewModel: ViperViewModel) {
        super.setupInitialState(with: viewModel)
        
        self.setupComponents()
        self.setupActions()
    }
    
    func setupImage(with imageData: Data) {
        photoImageView.image = UIImage(data: imageData)
    }
}

// MARK: - Actions
extension SavedFullImageViewController { }

// MARK: - Module functions
extension SavedFullImageViewController { }
