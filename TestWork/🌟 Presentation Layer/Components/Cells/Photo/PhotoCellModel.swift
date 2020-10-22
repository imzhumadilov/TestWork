//
//  PhotoCellModel.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

//import GKViper
import GKRepresentable

class PhotoCellModel: TableCellModel {
    
    typealias ActionHandler = (String) -> Void
    
    override var cellIdentifier: String {
        return PhotoCell.identifier
    }
    
    public var action: ActionHandler?
    public var title: String
    public var imageUrl: String
    public var thumbnailImageUrl: String
    
    init(title: String, imageUrl: String, thumbnailImageUrl: String) {
        self.title = title
        self.imageUrl = imageUrl
        self.thumbnailImageUrl = thumbnailImageUrl
    }
}
