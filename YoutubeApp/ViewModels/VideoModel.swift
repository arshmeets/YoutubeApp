//
//  Video.swift
//  YoutubeApp
//
//  Created by Arshmeet Sodhi on 3/16/21.
//

import Foundation
import Alamofire


class VideoModel: ObservableObject {
    
    @Published var videos = [Video]()
    
    init() {
        getVideos()
    }
    
    func getVideos() {
        
        // Create a URL object
        guard let url = URL(string: "\(Constants.API_URL)/playlistItems")
        else {
            return
        }
        
        // Get a decoder
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        // Create A URL request
        AF.request(
            url,
            parameters: ["part": "snippet", "playlistId": Constants.PLAYLIST_ID, "key": Constants.API_KEY]
        )
        .validate()
        .responseDecodable(of: Response.self, decoder: decoder) { response in
            
            // Check that the call was successful
            switch response.result {
            case .success:
                break
                
            case.failure(let error):
                print(error.localizedDescription)
                return
                
            }
            
            // Update the UI with videos
            if let items = response.value?.items {
                DispatchQueue.main.async {
                    self.videos = items
                }
            }
            
        }
        
    }
    
}
