//
//  PhotoLocalRouter.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 25.10.2020.
//

import GKCoreData
import CoreData

enum PhotoLocalRouter {
    case listAll
    case photos(albumId: String)
    
    var entityClass: AnyClass {
        return PhotoEntity.self
    }
    
    var request: NSFetchRequest<NSManagedObject> {
        switch self {
        case .listAll:
            return LocalFactory.request(entityClass, predicate: nil, sortDescriptors: nil)
        case .photos(let albumId):
            let predicate = NSPredicate(format: "albumId = %@", albumId)
            return LocalFactory.request(entityClass, predicate: predicate, sortDescriptors: nil)
        }
    }
}
