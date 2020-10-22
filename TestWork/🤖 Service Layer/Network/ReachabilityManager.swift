//
//  ReachabilityManager.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 22.10.2020.
//

import Foundation
import Alamofire

enum ReachabilityManager {
    static let sharedInstance = NetworkReachabilityManager()
    static var isConnectedToInternet: Bool {
        return self.sharedInstance?.isReachable ?? false
    }
}
