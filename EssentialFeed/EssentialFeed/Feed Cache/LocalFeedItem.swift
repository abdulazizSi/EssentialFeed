//
//  LocalFeedItem.swift
//  EssentialFeed
//
//  Created by Abdulaziz Alsikh on 2.02.2025.
//

import Foundation

// Data Transfer Objects DTO's
public struct LocalFeedItem: Equatable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let imageURL: URL
    
    public init(id: UUID, description: String?, location: String?, imageURL: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.imageURL = imageURL
    }
}
