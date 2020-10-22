//
//  AlbumCellModel.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 21.10.2020.
//

//import GKViper
import GKRepresentable

class AlbumCellModel: TableCellModel {
    
    override var cellIdentifier: String {
        return AlbumCell.identifier
    }
    
    public var album: Album
    
    init(album: Album) {
        self.album = album
    }
}
