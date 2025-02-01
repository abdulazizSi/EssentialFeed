//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Abdulaziz Alsikh on 1.02.2025.
//

import XCTest
import EssentialFeed

class LocalFeedLoader {
    let store: FeedStore
    
    init(store: FeedStore) {
        self.store = store
    }
    
    func save(_ items: [FeedItem]) {
        store.deleteCachedFeed()
    }
}

class FeedStore {
    var deleteCashFeedCallCount = 0
    
    func deleteCachedFeed() {
        deleteCashFeedCallCount += 1
    }
}

class CacheFeedUseCaseTests: XCTestCase {
    
    func test_init_doesNotDeleteCacheUponCreation() {
        let store = FeedStore()
        _ = LocalFeedLoader(store: store)
        
        XCTAssertEqual(store.deleteCashFeedCallCount, 0)
    }
        
    func test_save_requestCacheDeletion() {
        let store = FeedStore()
        let sut = LocalFeedLoader(store: store)
        let items = [uniqueItem(), uniqueItem()]
       
        sut.save(items)
        
        XCTAssertEqual(store.deleteCashFeedCallCount, 1)
    }
    
    //MARK: - Helper
    private func uniqueItem() -> FeedItem {
        return FeedItem(
            id: UUID(),
            description: "any",
            location: "any",
            imageURL: anyURL()
        )
    }
 
    private func anyURL() -> URL {
        URL(string: "https://any-url.com")!
    }
}
