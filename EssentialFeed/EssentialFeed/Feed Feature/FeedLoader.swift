//
//  Copyright © Essential Developer. All rights reserved.
//

import Foundation

typealias LoadFeedResult = Result<[FeedItem], Error>

protocol FeedLoader {
	func load(completion: @escaping (LoadFeedResult) -> Void)
}
