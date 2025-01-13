//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Abdulaziz Alsikh on 8.01.2025.
//

import XCTest
import EssentialFeed

class URLSessionHTTPClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        session.dataTask(with: url) { _,_, error in
            if let error {
                completion(.failure(error))
            }
        }.resume()
    }
}

class URLSessionHTTPClientTests: XCTestCase {

    func test_getFromURL_performsGetRequestWithURL() {
        URLProtocolStub.performInterceptedRequest {
            let url = URL(string: "https://example.com")!
            let exp = expectation(description: "Wait for request")
            
            URLProtocolStub.observeRequest { request in
                XCTAssertEqual(request.url, url)
                XCTAssertEqual(request.httpMethod, "GET")
                exp.fulfill()
            }
            
            URLSessionHTTPClient().get(from: url) { _ in }
            
            wait(for: [exp], timeout: 1.0)
        }
    }
    
    func test_getFromURL_failsOnRequestError() {
//        URLProtocolStub.startInterceptingRequests()
        
        URLProtocolStub.performInterceptedRequest {
            let url = URL(string: "https://example.com")!
            let error = NSError(domain: "any error", code: 1)
            URLProtocolStub.stub(data: nil, response: nil, error: error)
            
            let sut = URLSessionHTTPClient()
            
            let exp = expectation(description: "Wait for completion")
            
            sut.get(from: url) { result in
                switch result {
                case let .failure(receivedError as NSError):
                    XCTAssertEqual(receivedError.domain, error.domain)
                    XCTAssertEqual(receivedError.code, error.code)
                default:
                    XCTFail("Expected failure with \(error), got \(result) instead")
                }
                
                exp.fulfill()
            }
            
            wait(for: [exp], timeout: 1.0)
        }
        
//        URLProtocolStub.stopInterceptingRequests()
    }
    
    //MARK: - Helper
    
    private class URLProtocolStub: URLProtocol {
        private static var stub: Stub?
        
        private static var requestObserver: ((URLRequest) -> Void)?
        
        private struct Stub {
            let data: Data?
            let response: URLResponse?
            let error: Error?
        }
        
        static func stub(data: Data?, response: URLResponse?, error: Error?) {
            stub = Stub(data: data, response: response, error: error)
        }
        
        static func observeRequest(request: @escaping ((URLRequest) -> Void)) {
            requestObserver = request
        }
        
        static func performInterceptedRequest(_ request: () -> Void ) {
            startInterceptingRequests()
            request()
            stopInterceptingRequests()
        }
        
        static func startInterceptingRequests() {
            URLProtocol.registerClass(URLProtocolStub.self)
        }
        
        static func stopInterceptingRequests() {
            URLProtocol.unregisterClass(URLProtocolStub.self)
            URLProtocolStub.stub = nil
            requestObserver = nil
        }
        
        override class func canInit(with request: URLRequest) -> Bool {
            requestObserver?(request)
            return true
        }
        
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            request
        }
        
        override func startLoading() {
            if let data = URLProtocolStub.stub?.data {
                client?.urlProtocol(self, didLoad: data)
            }
            
            if let response = URLProtocolStub.stub?.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            
            if let error = URLProtocolStub.stub?.error {
                client?.urlProtocol(self, didFailWithError: error)
            }
            
            client?.urlProtocolDidFinishLoading(self)
        }
        
        override func stopLoading() {}
    }
}
