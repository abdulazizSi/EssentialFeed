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
//        dataTask(with: url) { _,_, error in
//            if let error {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
//}
