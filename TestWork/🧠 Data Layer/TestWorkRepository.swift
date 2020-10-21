//
//  TestWorkRepository.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 21.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKUseCase
import GKNetwork
import GKViper

public class TestWorkRepository: Repository {
    
    public lazy var TestWorkRemoteInterface: TestWorkRemoteWorkerInterface = TestWorkRemoteWorker()
    
    init() {
        super.init(modelName: "TestWork")
    }
    
    override public func execute<T: Codable>(_ request: URLRequest, response: T.Type, completion: ((Any?, HTTPURLResponse?, Error?) -> Void)? = nil) {
        self.TestWorkRemoteInterface.execute(request, model: response) { (result, requestResponse, error) in
            switch requestResponse?.statusCode {
            case 200:
                if let arrayResult = result as? [RemoteMappable] {
                    let mappedResult = arrayResult.map({ $0.mapResponseToDomain() })
                    
                    guard let completion = completion else { return }
                    completion(mappedResult, requestResponse, error)
                } else if let singleResult = result as? RemoteMappable {
                    let mappedResult = singleResult.mapResponseToDomain()
                    
                    guard let completion = completion else { return }
                    completion(mappedResult, requestResponse, error)
                } else if let result = result as? String {
                    guard let completion = completion else { return }
                    completion(result, requestResponse, error)
                } else {
                    guard let completion = completion else { return }
                    completion(nil, requestResponse, error)
                }
            default:
                guard let completion = completion else { return }
                completion(nil, requestResponse, error)
                
                if let statusCode = requestResponse?.statusCode {

                }
            }
        }
    }
}
