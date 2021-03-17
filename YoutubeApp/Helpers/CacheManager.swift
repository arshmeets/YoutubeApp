//
//  CacheManager.swift
//  YoutubeApp
//
//  Created by Arshmeet Sodhi on 3/16/21.
//

import Foundation


class CacheManager {
    
    static var cache = [String : Data]()
    
    static func setVideoCache(_ url: String, _ data: Data?) {
        // Store the image data with the url as the key
        cache[url] = data
    }
    
    static func getVideoCache(_ url: String) -> Data? {
        // Try and get the data for the specified URL
        return cache[url]
    }
    
}
