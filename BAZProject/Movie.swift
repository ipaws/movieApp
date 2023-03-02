//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let poster_path: String
    let overview: String
    
     var urlImage: String{
        return "https://image.tmdb.org/t/p/w500/\(poster_path)"
    }
}

struct MoviesResponse: Codable {
    let page: Int
    let results: [Movie]
    let total_results: Int
    let total_pages: Int
}

struct Cast: Codable{
    let name: String?
    let profile_path: String?
    let character: String?
}



