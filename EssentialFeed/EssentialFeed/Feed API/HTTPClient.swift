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
