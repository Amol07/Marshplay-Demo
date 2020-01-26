//
//  MovieDetailsProtocol.swift
//  Marsplay
//
//  Created by Amol Prakash on 27/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

// Presenter to View
protocol MovieDetailsViewProtocol: AnyObject {
    var presenter: MovieDetailsPresenterProtocol? { get set }
    func displayUI(for movie: Movie?)
}

// View to Presenter
protocol MovieDetailsPresenterProtocol: AnyObject {
    var view: MovieDetailsViewProtocol? { get set }
    var movie: Movie? { get set }
   
    init(movie: Movie)
    func viewDidLoad()
}
