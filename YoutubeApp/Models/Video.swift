//
//  Video.swift
//  YoutubeApp
//
//  Created by Arshmeet Sodhi on 3/15/21.
//

import Foundation

struct Video: Decodable {
    
    var videoId = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var published = Date()
    
    enum CodingKeys: String, CodingKey {
        
        case snippit
        case thumbnails
        case high
        case resourceId
        case published = "publishedAt"
        case title
        case description
        case thumbnail = "url"
        case videoId
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippit)
        
        // Parse the title
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        
        // Parse the description
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        
        // Parse the published date
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        
        // Parse the thumbnails
        let thumbnailContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        
        let highContainer = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        
        // Parse the video id
        let resourceidContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        
        self.videoId = try resourceidContainer.decode(String.self, forKey: .videoId)
        
    }
    
}
