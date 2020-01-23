//
//  Movies.swift
//  Marsplay
//
//  Created by Amol Prakash on 22/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

enum MovieType: String, Decodable {
    case movie
    case series
    case episode
}

class Movies: Decodable {
    var title: String?
    var year: String?
    var imdbID: String?
    var type: MovieType?
    var poster: String?
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

class MoviesResponse<T:Decodable>: Decodable {
    var result: [T]?
    var totalResults: Int = 0
    var response: String?
    
    private enum CodingKeys: String, CodingKey {
        case result = "Search"
        case totalResults
        case response = "Response"
    }
    
    var isSuccessResponse: Bool {
        guard let response = self.response, let success = Bool(response.lowercased()) else {
            return false
        }
        return success
    }
}
