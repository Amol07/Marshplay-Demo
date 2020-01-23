//
//  MoviesListRouter.swift
//  Marsplay
//
//  Created by Amol Prakash on 22/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation
import UIKit

var mainStoryboard: UIStoryboard {
    return UIStoryboard(name: "Main", bundle: Bundle.main)
}

class MoviesListRouter: MovieListRouterProtocol {
    
    static func createMovieListModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "MoviesNavigationController")
        if let view = navController.children.first as? MoviesListViewController {
            let presenter: MovieListPresenterProtocol & MovieListInteractorOutputProtocol = MoviesListPresenter()
            let interactor: MovieListInteractorInputProtocol & MovieListFetcherOutputProtocol = MoviesListInteractor()
            let remoteDataFetcher: MovieListFetcherInputProtocol = MoviesListFetcher()
            let router: MovieListRouterProtocol = MoviesListRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.fetcher = remoteDataFetcher
            remoteDataFetcher.interactor = interactor
            return navController
        }
        return UIViewController()
    }
    
}
