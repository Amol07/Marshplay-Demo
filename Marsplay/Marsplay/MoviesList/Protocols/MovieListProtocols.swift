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
    
    func loadingFinished(with indicies: [IndexPath])
    func hideActivity()
    func showActivity()
}

// View to Presenter
protocol MovieListPresenterProtocol: AnyObject {
    var view: MovieListViewProtocol? { get set }
    var interactor: MovieListInteractorInputProtocol? { get set }
    var router: MovieListRouterProtocol? { get set }
    
    func viewDidLoad()
    func getMovies()
    func numberOfItemsIn(section: Int) -> Int
    func getItemAt(indexPath: IndexPath) -> Movie
    func selectedItemAt(indexpath: IndexPath)
}

// Presenter to Interactor
protocol MovieListInteractorInputProtocol: AnyObject {
    var presenter: MovieListInteractorOutputProtocol? { get set }
    var fetcher: MovieListFetcherInputProtocol? { get set }
    
    func getMoviesListFor(page: Int)
    
}

// Interactor to Presenter
protocol MovieListInteractorOutputProtocol: AnyObject {
    func didFetch(response: MoviesResponse<Movie>)
    func failedWith(error: MarsplayError?)
}

// Interactor to Fetcher
protocol MovieListFetcherInputProtocol: AnyObject {
    var interactor: MovieListFetcherOutputProtocol? { get set }
    func getMovies(for searchString: String, page: Int)
}

// Fetcher to Interactor
protocol MovieListFetcherOutputProtocol: AnyObject {
    func didFetchMovies(response: MoviesResponse<Movie>)
    func failedWith(error: MarsplayError?)
}

// Presenter to Router
protocol MovieListRouterProtocol {
    
}


