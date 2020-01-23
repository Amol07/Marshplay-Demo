//
//  MovieListProtocols.swift
//  Marsplay
//
//  Created by Amol Prakash on 22/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

// Presenter to View
protocol MovieListViewProtocol: AnyObject {
    var presenter: MovieListPresenterProtocol? { get set }
    
    func loadingFinished()
    func hideActivity()
    func showActivity()
}

// View to Presenter
protocol MovieListPresenterProtocol: AnyObject {
    var view: MovieListViewProtocol? { get set }
    var interactor: MovieListInteractorInputProtocol? { get set }
    var router: MovieListInteractorInputProtocol? { get set }
    
    func viewDidLoad()
    func getMovies()
    func numberOfItemsIn(section: Int) -> Int
    func selectedItemAt(indexpath: IndexPath)
}

// Presenter to Interactor
protocol MovieListInteractorInputProtocol: AnyObject {
    var presenter: MovieListInteractorOutputProtocol? { get set }
    var fetcher: MovieListFetcherInputProtocol? { get set }
    var response: MoviesResponse<Movies>? { get set }
    
    func getMoviesListFor(page: Int)
    
}

// Interactor to Presenter
protocol MovieListInteractorOutputProtocol: AnyObject {
    func didFetch<T: Decodable>(movies: T)
}

// Interactor to Fetcher
protocol MovieListFetcherInputProtocol: AnyObject {
    var interactor: MovieListFetcherOutProtocol? { get set }
    func getMovies(for searchString: String, page: Int)
}

// Fetcher to Interactor
protocol MovieListFetcherOutProtocol: AnyObject {
    func didFetchMovies<T: Decodable>(response: T)
}

// Presenter to Router
protocol MovieListRouterProtocol {
    
}


