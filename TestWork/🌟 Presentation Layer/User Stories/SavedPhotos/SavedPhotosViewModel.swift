//
//  SavedPhotosViewModel.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 26.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper

class SavedPhotosViewModel: ViperViewModel {
    public var albumId: String
    public var photos: [Photo] = []
    
    init(albumId: String) {
        self.albumId = albumId
    }
}
