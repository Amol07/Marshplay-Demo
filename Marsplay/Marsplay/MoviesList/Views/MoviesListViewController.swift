//
//  MoviesListViewController.swift
//  Marsplay
//
//  Created by Amol Prakash on 22/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {
    var presenter: MovieListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MoviesListViewController: MovieListViewProtocol {
    
    func loadingFinished() {
        // reload collection
    }
    
    func hideActivity() {
        // remove activity
    }
    
    func showActivity() {
        // display activity
    }
}
