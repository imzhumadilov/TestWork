//
//  SavedPhotoCellModel.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 26.10.2020.
//

import GKRepresentable

class SavedPhotoCellModel: TableCellModel {
    
    typealias ActionHandler = (Data) -> Void
    
    override var cellIdentifier: String {
        return SavedPhotoCell.identifier
    }
    
    public var action: ActionHandler?
    public var title: String
    public var imageData: Data
    
    init(title: String, imageData: Data) {
        self.title = title
        self.imageData = imageData
    }
}
