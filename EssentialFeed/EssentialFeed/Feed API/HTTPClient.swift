//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Abdulaziz Alsikh on 6.01.2025.
//

import Foundation

public typealias HTTPClientResult = Result<(Data, HTTPURLResponse), Error>

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

//extension URLSession: HTTPClient {
//    public func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
//        dataTask(with: url) { data, response, error in
//            let completionBlock: HTTPClientResult
//                                       
//            guard error == nil else  {
//                completionBlock = .failure(error!)
//                return
//            }
//            
//            guard let data, let response = response as? HTTPURLResponse else {
//                completionBlock = .failure(RemoteFeedLoader.Error.invalidData)
//                return
//            }
//            
//            completionBlock = .success((data, response))
//            
//            completion(completionBlock)
//        }
//    }
//}
