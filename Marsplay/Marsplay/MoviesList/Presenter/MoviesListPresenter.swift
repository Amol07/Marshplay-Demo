//
//  MoviesListPresenter.swift
//  Marsplay
//
//  Created by Amol Prakash on 22/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

struct PageInfo {
    var isNextAvailable = true
    var currentPage = 1
    var isApiCallInProgress = false
}

class MoviesListPresenter: MovieListPresenterProtocol {
    
    weak var view: MovieListViewProtocol?
    var interactor: MovieListInteractorInputProtocol?
    var router: MovieListRouterProtocol?
     
    private var moviesList: [Movies] = [Movies]()
    private var pageInfo = PageInfo()
    
    func viewDidLoad() {
        self.getMovies()
    }
    
    func getMovies() {
        guard !self.pageInfo.isApiCallInProgress, self.pageInfo.isNextAvailable else { return }
        self.interactor?.getMoviesListFor(page: self.pageInfo.currentPage)
    }
    
    func numberOfItemsIn(section: Int) -> Int {
        return self.moviesList.count
    }
    
    func selectedItemAt(indexpath: IndexPath) {
        //let movies = self.moviesList[indexpath.item]
    }
}

extension MoviesListPresenter: MovieListInteractorOutputProtocol {
    
    func didFetch(response: MoviesResponse<Movies>) {
        
        guard response.isSuccessResponse, let movies = response.result, movies.count > 0 else {
            self.pageInfo.isNextAvailable = false
            return
        }
        self.pageInfo.isApiCallInProgress = false
        self.pageInfo.currentPage = self.pageInfo.currentPage + 1
        self.pageInfo.isNextAvailable = self.moviesList.count < response.totalCount
        
        let startIndex = self.moviesList.count
        self.moviesList.append(contentsOf: movies)
        let endIndex = self.moviesList.count - 1
        let indicies = Array(startIndex...endIndex).map { IndexPath(item: $0, section: 0) }
        self.view?.loadingFinished(with: indicies)
    }
    
    func failedWith(error: MarsplayError?) {
        
    }
}
