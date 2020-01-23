//
//  MoviesListPresenter.swift
//  Marsplay
//
//  Created by Amol Prakash on 22/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

class MoviesListPresenter: MovieListPresenterProtocol {
    
    weak var view: MovieListViewProtocol?
    var interactor: MovieListInteractorInputProtocol?
    var router: MovieListInteractorInputProtocol?
     
    private var moviesList: [Movies] = [Movies]()
    private var isNextPageAvailable: Bool = false
    private var isNextPageCallInProgress: Bool = false
    private var currentPage: Int = 1
    
    func viewDidLoad() {
        self.getMovies()
    }
    
    func getMovies() {
        guard let resultCount = self.interactor?.response?.result?.count, self.moviesList.count < resultCount else { return }
        self.interactor?.getMoviesListFor(page: self.currentPage)
    }
    
    func numberOfItemsIn(section: Int) -> Int {
        return self.moviesList.count
    }
    
    func selectedItemAt(indexpath: IndexPath) {
        //let movies = self.moviesList[indexpath.item]
    }
}

extension MoviesListPresenter: MovieListInteractorOutputProtocol {
    func didFetch<T>(movies: T) where T : Decodable {
        
    }
    
    
    func didFetch(movies: [Movies]) {
        guard movies.count > 0 else {
            return
        }
        // let startIndex = self.moviesList.count
        self.moviesList.append(contentsOf: movies)
        // let endIndex = self.moviesList.count - 1
        self.view?.loadingFinished()
    }
}
