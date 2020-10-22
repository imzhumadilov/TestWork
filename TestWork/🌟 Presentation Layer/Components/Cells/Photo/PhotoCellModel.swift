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
    public var photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
    }
}
