//
//  RemoteFeedLoaderTest.swift
//  EssentialFeedTests
//
//  Created by Abdulaziz Alsikh on 4.01.2025.
//


import XCTest

class RemoteFeedLoader {
    func load() {
        HTTPClient.shared.get(from: URL(string: "HTTPs://google.com")!)
    }
}

class HTTPClient {
    static var shared = HTTPClient()
    
    func get(from url: URL) { }
     
    var requesteURL: URL?
}

class HTTPClientSpy: HTTPClient {
    
    override func get(from url: URL) {
        requesteURL = url
    }
}

class RemoteFeedLoaderTest: XCTestCase {

    
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requesteURL)
    }

    func test_load_requestsDataFromURL() {
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        let loader = RemoteFeedLoader()
        
        loader.load()
        
        XCTAssertNotNil(client.requesteURL)
    }
    
}
