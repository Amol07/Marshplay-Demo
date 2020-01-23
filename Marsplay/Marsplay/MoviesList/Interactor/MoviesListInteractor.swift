//
//  MoviesListInteractor.swift
//  Marsplay
//
//  Created by Amol Prakash on 22/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

class MoviesListInteractor: MovieListInteractorInputProtocol {
    
    weak var presenter: MovieListInteractorOutputProtocol?
    var fetcher: MovieListFetcherInputProtocol?
    var response: MoviesResponse<Movies>?
    
    func getMoviesListFor(page: Int) {
        self.fetcher?.getMovies(for: "Batman", page: page)
    }
    
}

extension MoviesListInteractor: MovieListFetcherOutProtocol {
    func didFetchMovies<T: Decodable>(response: T) {
        
    }
}
