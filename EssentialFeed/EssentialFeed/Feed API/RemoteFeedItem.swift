//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Abdulaziz Alsikh on 2.02.2025.
//

import Foundation

struct RemoteFeedItem: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL
}
