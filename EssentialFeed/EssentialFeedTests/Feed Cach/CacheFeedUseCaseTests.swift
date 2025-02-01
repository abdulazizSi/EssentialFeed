//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Abdulaziz Alsikh on 1.02.2025.
//

import XCTest

class LocalFeedLoader {
    init(store: FeedStore) {

    }
}

class FeedStore {
    var deleteCashFeedCallCount = 0
}

class CacheFeedUseCaseTests: XCTestCase {
    
    func test_init_doesNotDeleteCacheUponCreation() {
        let store = FeedStore()
        _ = LocalFeedLoader(store: store)
        
        XCTAssertEqual(store.deleteCashFeedCallCount, 0)
    }
        
}
