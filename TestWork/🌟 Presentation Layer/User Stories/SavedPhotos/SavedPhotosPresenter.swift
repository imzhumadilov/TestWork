//
//  SavedPhotosPresenter.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 26.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper
import GKRepresentable

protocol SavedPhotosPresenterInput: ViperPresenterInput { }

class SavedPhotosPresenter: ViperPresenter, SavedPhotosPresenterInput, SavedPhotosViewOutput {
    
    // MARK: - Props
    fileprivate var view: SavedPhotosViewInput? {
        guard let view = self._view as? SavedPhotosViewInput else {
            return nil
        }
        return view
    }
    
    fileprivate var router: SavedPhotosRouterInput? {
        guard let router = self._router as? SavedPhotosRouterInput else {
            return nil
        }
        return router
    }
    
    private let photoUseCase: PhotoUseCaseInput
    var viewModel: SavedPhotosViewModel
    
    // MARK: - Initialization
    init(albumId: String) {
        self.viewModel = SavedPhotosViewModel(albumId: albumId)
        photoUseCase = PhotoUseCase()
        
        super.init()
        photoUseCase.subscribe(with: self)
    }
    
    // MARK: - SavedPhotosPresenterInput
    
    // MARK: - SavedPhotosViewOutput
    override func viewIsReady(_ controller: UIViewController) {
        self.view?.setupInitialState(with: self.viewModel)
        
        photoUseCase.localGetPhotos(with: viewModel.albumId)
    }
        
    // MARK: - Module functions
    private func makeSections(with photos: [Photo]) {
        
        let mainSection = TableSectionModel()
        
        for photo in photos {
            let photoModel = SavedPhotoCellModel(title: photo.title,
                                                 imageData: photo.image.data)
            photoModel.action = { [weak self] imageData in
                self?.router?.pushFullImageVC(with: imageData)
            }
            mainSection.rows.append(photoModel)
        }
        view?.updateSections([mainSection])
    }
}

extension SavedPhotosPresenter: PhotoUseCaseOutput {
    func localGotPhotos(_ photos: [Photo]) {
        makeSections(with: photos)
    }
}
