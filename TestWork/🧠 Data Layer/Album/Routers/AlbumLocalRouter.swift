//
//  AlbumLocalRouter.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 23.10.2020.
//

import GKCoreData
import CoreData

enum AlbumLocalRouter {
    case listAll
    case album(id: String)
    
    var entityClass: AnyClass {
        return AlbumEntity.self
    }
    
    var request: NSFetchRequest<NSManagedObject> {
        switch self {
        case .listAll:
            return LocalFactory.request(entityClass, predicate: nil, sortDescriptors: nil)
        case .album(let id):
            let predicate = NSPredicate(format: "id = %@", id)
            return LocalFactory.request(entityClass, predicate: predicate, sortDescriptors: nil)
        }
    }
}
