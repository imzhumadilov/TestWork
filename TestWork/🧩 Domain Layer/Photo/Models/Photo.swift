//
//  Photo.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

import Foundation

class Photo {
    
    // MARK: - Props
    let albumId: String
    let id: String
    let title: String
    var image: Image
    
    init(albumId: String, id: String, title: String, image: Image) {
        self.albumId = albumId
        self.id = id
        self.title = title
        self.image = image
    }
}

struct Image {
    
    // MARK: - Props
    let url: String
    let thumbnailUrl: String
    var data: Data
}
