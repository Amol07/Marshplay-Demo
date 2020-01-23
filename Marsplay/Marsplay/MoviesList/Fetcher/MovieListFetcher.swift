//
//  MovieListFetcher.swift
//  Marsplay
//
//  Created by Amol Prakash on 22/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

class MovieListFetcher: MovieListFetcherInputProtocol {
    weak var interactor: MovieListFetcherOutProtocol?
    
    func getMovies(for searchString: String, page: Int) {
        // let queryParam = ["s": searchString, "page": page] as [String : Any]
    }
}
