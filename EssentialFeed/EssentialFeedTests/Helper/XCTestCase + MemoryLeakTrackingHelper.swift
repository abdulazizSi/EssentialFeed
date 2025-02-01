//
//  XCTestCase + MemoryLeakTrackingHelper.swift
//  EssentialFeedTests
//
//  Created by Abdulaziz Alsikh on 13.01.2025.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "Instance should have been deallocated, Potential memory leak.",
                file: file,
                line: line
            )
        }
    }
}
