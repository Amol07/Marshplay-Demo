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
    
    func getMoviesListFor(page: Int) {
        self.fetcher?.getMovies(for: "Batman", page: page)
    }
}

extension MoviesListInteractor: MovieListFetcherOutputProtocol {
    
    func failedWith(error: MarsplayError?) {
        self.presenter?.failedWith(error: error)
    }
    
    func didFetchMovies(response: MoviesResponse<Movie>) {
        self.presenter?.didFetch(response: response)
    }
}
