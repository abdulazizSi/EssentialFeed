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

class RemoteFeedLoaderTest: XCTestCase {

    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertNil(client.requesteURL)
    }

    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://example.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load()
        
        XCTAssertNotNil(client.requesteURL)
    }
    
    //MARK: - Helper
    
    private func makeSUT(url: URL = URL(string: "https://example.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
   private class HTTPClientSpy: HTTPClient {
        var requesteURL: URL?
        
        func get(from url: URL) {
            requesteURL = url
        }
    }
}
