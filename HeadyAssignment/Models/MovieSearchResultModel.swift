//
//  MovieSearchResultModel.swift
//  HeadyAssignment
//
//  Created by Durgesh Pandey on 06/02/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import ObjectMapper

struct MovieSearchResultModel: Mappable {
    
    var page: Int?
    var total_results: Int?
    var total_pages: Int?
    var results: [MovieSearchModel]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        page       <- map["page"]
        total_results       <- map["total_results"]
        total_pages       <- map["total_pages"]
        results       <- map["results"]
    }
}

struct MovieSearchModel: Mappable {
    
    var vote_count: Int?
    var id: Int?
    var video: Bool?
    var vote_average: Int?
    var title: String?
    var popularity: Double?
    var poster_path: String?
    var original_language: String?
    var original_title: String?
    var backdrop_path: String?
    var adult: Bool?
    var overview: String?
    var release_date: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        vote_count       <- map["vote_count"]
        id       <- map["id"]
        video       <- map["video"]
        vote_average       <- map["vote_average"]
        title       <- map["title"]
        popularity       <- map["popularity"]
        poster_path       <- map["poster_path"]
        original_language       <- map["original_language"]
        original_title       <- map["original_title"]
        backdrop_path       <- map["backdrop_path"]
        adult       <- map["adult"]
        overview       <- map["overview"]
        release_date       <- map["release_date"]
    }
    
    func getImageUrl() -> String {
        
        if let imagePath = self.poster_path {
            return "https://image.tmdb.org/t/p/w500\(imagePath)"
        } else {
            return ""
        }
    }
    
}
