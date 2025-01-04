//
//  RemoteFeedLoaderTest.swift
//  EssentialFeedTests
//
//  Created by Abdulaziz Alsikh on 4.01.2025.
//


import XCTest

class RemoteFeedLoader {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func load() {
        client.get(from: URL(string: "HTTPs://google.com")!)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}

class HTTPClientSpy: HTTPClient {
    var requesteURL: URL?
    
    func get(from url: URL) {
        requesteURL = url
    }
}

class RemoteFeedLoaderTest: XCTestCase {

    
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        _ = RemoteFeedLoader(client: client)
        
        XCTAssertNil(client.requesteURL)
    }

    func test_load_requestsDataFromURL() {
        let client = HTTPClientSpy()
        let loader = RemoteFeedLoader(client: client)
        
        loader.load()
        
        XCTAssertNotNil(client.requesteURL)
    }
    
}
