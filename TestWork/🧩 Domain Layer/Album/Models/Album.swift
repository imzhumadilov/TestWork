//
//  Album.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

import Foundation

class Album {
    
    // MARK: - Props
    let id: String
    let title: String
    var photos: [Photo]
    
    init(id: String, title: String, photos: [Photo]) {
        self.id = id
        self.title = title
        self.photos = photos
    }
}
