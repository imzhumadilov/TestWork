//
//  TestWorkRemoteWorker.swift
//  TestWork
//
//  Created by Ilyas Zhumadilov on 21.10.2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import GKNetwork

public protocol TestWorkRemoteWorkerInterface: AnyObject {
    func execute<T: Codable>(_ request: URLRequest, model: T.Type, completion: @escaping (_ result: Codable?, _ response: HTTPURLResponse?, _ error: Error?) -> Void)
    func cancel(_ request: URLRequest)
}

open class TestWorkRemoteWorker: NSObject, TestWorkRemoteWorkerInterface {
    
    // MARK: - Props
    private var activeTasks: [String: URLSessionDataTask]
    
    var urlSession: URLSession?
    
    // MARK: - Initialization
    public override init() {
        self.activeTasks = [:]
    }
    
    // MARK: - RemoteWorkerInterface
    public func execute<T: Codable>(_ request: URLRequest, model: T.Type, completion: @escaping (_ result: Codable?, _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        guard let taskAbsoluteString: String = request.url?.absoluteString else {
            let invalidRequestError = NSError(domain: "[RemoteWorker] - Invalid request",
                                              code: 400,
                                              userInfo: nil)
            completion(nil, nil, invalidRequestError)
            
            return
        }
        if self.activeTasks[taskAbsoluteString] != nil {
            self.activeTasks[taskAbsoluteString]?.cancel()
        }
        self.urlSession = URLSession(configuration: .default)
        let newTask = self.urlSession?.dataTask(with: request) { (data, response, error) in
            if let receivedData = data, let receivedResponse = response as? HTTPURLResponse, error == nil {
                NSLog("[RemoteWorker] - Response: \(receivedResponse)")
                
                switch receivedResponse.statusCode {
                case 200:
                    if let okString = String(data: receivedData, encoding: .utf8), okString.lowercased() == "ok" {
                        self.activeTasks[taskAbsoluteString] = nil
                        completion(nil, receivedResponse, nil)
                        
                        return
                    }
                    
                    do {
                        let jsonDecoder = JSONDecoder()
                        let object = try jsonDecoder.decode(model, from: receivedData)
                        print("[NetworkWorker] - Data: \(object)")
                        
                        self.activeTasks[taskAbsoluteString] = nil
                        completion(object, receivedResponse, nil)
                    } catch let parsingError {
                        self.activeTasks[taskAbsoluteString] = nil
                        if response?.url?.lastPathComponent == "point", let str = String(data: receivedData, encoding: .utf8), !str.isEmpty {
                            let count = str.count
                            completion("\("\(str.prefix(count - 1))".suffix(count - 2))", receivedResponse, nil)
                        } else {
                            completion(nil, receivedResponse, parsingError)
                        }
                    }
                default:
                    let serverError = NSError(domain: "",
                                              code: receivedResponse.statusCode,
                                              userInfo: nil)
                    self.activeTasks[taskAbsoluteString] = nil
                    completion(nil, receivedResponse, serverError)
                }
            } else {
                NSLog("[RemoteWorker] - Error: \(error?.localizedDescription ?? "unknown error")")
                if let receivedResponse = response as? HTTPURLResponse {
                    NSLog("[RemoteWorker] - Response: \(receivedResponse)")
                    self.activeTasks[taskAbsoluteString] = nil
                    completion(nil, receivedResponse, error)
                } else {
                    self.activeTasks[taskAbsoluteString] = nil
                    completion(nil, nil, error)
                }
            }
        }
        
        self.activeTasks[taskAbsoluteString] = newTask
        self.activeTasks[taskAbsoluteString]?.resume()
    }
    
    public func cancel(_ request: URLRequest) {
        guard let taskAbsoluteString: String = request.url?.absoluteString else { return }
        
        if self.activeTasks[taskAbsoluteString] != nil {
            self.activeTasks[taskAbsoluteString]?.cancel()
        }
    }
    
    // MARK: - Module functions
}
