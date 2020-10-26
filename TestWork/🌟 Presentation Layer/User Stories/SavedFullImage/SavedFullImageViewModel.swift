//
//  SavedFullImageViewModel.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 26.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKViper

class SavedFullImageViewModel: ViperViewModel {
    public var imageData: Data
    
    init(imageData: Data) {
        self.imageData = imageData
    }
}
