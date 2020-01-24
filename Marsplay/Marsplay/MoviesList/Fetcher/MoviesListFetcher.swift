//
//  MoviesListFetcher.swift
//  Marsplay
//
//  Created by Amol Prakash on 22/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

class MoviesListFetcher: MovieListFetcherInputProtocol {
    weak var interactor: MovieListFetcherOutputProtocol?
    
    func getMovies(for searchString: String, page: Int) {
        let queryParam = ["s": searchString, "page": "\(page)"]
        ApiClient<MoviesResponse<Movie>>.makeRequest(toURL: Endpoints.Movies.fetch.url, queryParameters: queryParam, bodyParameters: nil) { [weak self] response, error  in
            guard let response = response else {
                self?.interactor?.failedWith(error: error)
                return
            }
            self?.interactor?.didFetchMovies(response: response)
        }
    }
}
