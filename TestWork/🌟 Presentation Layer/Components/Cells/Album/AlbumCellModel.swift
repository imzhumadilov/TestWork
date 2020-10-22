//
//  AlbumCellModel.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 21.10.2020.
//

//import GKViper
import GKRepresentable

class AlbumCellModel: TableCellModel {
    
    typealias ActionHandler = () -> Void
    
    override var cellIdentifier: String {
        return AlbumCell.identifier
    }
    
    public var action: ActionHandler?
    public var title: String
    
    init(title: String) {
        self.title = title
    }
}
