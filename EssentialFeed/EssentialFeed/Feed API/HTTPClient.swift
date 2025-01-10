//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Abdulaziz Alsikh on 6.01.2025.
//

import Foundation

public typealias HTTPClientResponse = Result<(Data, HTTPURLResponse), Error>

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResponse) -> Void)
}

//extension URLSession: HTTPClient {
//    public func get(from url: URL, completion: @escaping (HTTPClientResponse) -> Void) {
//        dataTask(with: url) { data, response, error in
//            let completionBlock: HTTPClientResponse
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
