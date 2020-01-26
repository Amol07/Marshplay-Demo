//
//  MovieDetailsPresenter.swift
//  Marsplay
//
//  Created by Amol Prakash on 27/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

class MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    
    var view: MovieDetailsViewProtocol?
    var movie: Movie?
    
    required init(movie: Movie) {
        self.movie = movie
    }
    func viewDidLoad() {
        self.view?.displayUI(for: self.movie)
    }
}
