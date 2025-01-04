//
//  RemoteFeedLoaderTest.swift
//  EssentialFeedTests
//
//  Created by Abdulaziz Alsikh on 4.01.2025.
//


import XCTest

class RemoteFeedLoader {
    func load() {
        HTTPClient.shared.requesteURL = URL(string: "HTTPs://google.com")
    }
}

class HTTPClient {
    static let shared = HTTPClient()
    
    private init() { }
    
    var requesteURL: URL?
}

class RemoteFeedLoaderTest: XCTestCase {

    
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient.shared
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requesteURL)
    }

    func test_load_requestsDataFromURL() {
        let client = HTTPClient.shared
        let loader = RemoteFeedLoader()
        
        loader.load()
        
        XCTAssertNotNil(client.requesteURL)
    }
    
}
