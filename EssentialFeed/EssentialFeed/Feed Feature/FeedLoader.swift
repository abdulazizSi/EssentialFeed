//
//  Copyright © Essential Developer. All rights reserved.
//

import Foundation

//public typealias LoadFeedResult = Result<[FeedItem], Error>

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

protocol FeedLoader {
	func load(completion: @escaping (LoadFeedResult) -> Void)
}
