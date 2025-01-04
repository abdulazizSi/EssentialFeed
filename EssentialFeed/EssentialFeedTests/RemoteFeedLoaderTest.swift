//
//  RemoteFeedLoaderTest.swift
//  EssentialFeedTests
//
//  Created by Abdulaziz Alsikh on 4.01.2025.
//


import XCTest

class RemoteFeedLoader {
    let client: HTTPClient
    let url: URL
    
    init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    func load() {
        client.get(from: self.url)
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
        let url = URL(string: "https://example.com")!
        let client = HTTPClientSpy()
        _ = RemoteFeedLoader(url: url, client: client)
        
        XCTAssertNil(client.requesteURL)
    }

    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://example.com")!
        let client = HTTPClientSpy()
        let loader = RemoteFeedLoader(url: url, client: client)
        
        loader.load()
        
        XCTAssertNotNil(client.requesteURL)
    }
    
}
