//
//  Photo.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

import Foundation

struct Photo {
    
    // MARK: - Props
    let albumId: String
    let id: String
    let title: String
    var image: Image
}

struct Image {
    
    // MARK: - Props
    let url: String
    let thumbnailUrl: String
    var data: Data
}
