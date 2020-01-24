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
    case game
}

class Movie: Decodable {
    private static let dateFormatter = DateFormatter()
    
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
    private(set) var formattedDateString: String?
    var yearsAgo: String? {
        guard formattedDateString != nil else {
            Movie.dateFormatter.dateFormat = "yyyy"
            if let year = self.year, let date = Movie.dateFormatter.date(from: year) {
                self.formattedDateString = date.timeAgo(since: date)
            } else {
                self.formattedDateString = self.year
            }
            return self.formattedDateString
        }
        return self.formattedDateString
    }
}

class MoviesResponse<T:Decodable>: Decodable {
    var result: [T]?
    var totalResults: String?
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
    
    var totalCount: Int {
        guard let total = self.totalResults else {
            return 0
        }
        return Int(total) ?? 0
    }
}
