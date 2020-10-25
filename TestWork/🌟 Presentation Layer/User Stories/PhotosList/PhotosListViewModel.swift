//
//  PhotosListViewModel.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper

class PhotosListViewModel: ViperViewModel {
    public var album: Album
    public var sourcePhotos: [Photo] = [] {
        didSet {
            album.photos = sourcePhotos
        }
    }
    public var photos: [Photo] = [] {
        didSet {
            album.photos = photos
        }
    }
    
    init(album: Album) {
        self.album = album
    }
}
