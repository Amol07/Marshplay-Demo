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
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.presenter?.viewDidLoad()
    }
    
    private func registerCells() {
        self.collectionView.register(cellType: MovieListCollectionViewCell.self)
    }
}

extension MoviesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = self.presenter else { return 0 }
        return presenter.numberOfItemsIn(section: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MovieListCollectionViewCell.self)
        guard let presenter = self.presenter else { return cell }
        cell.configureCell(withMovie: presenter.getItemAt(indexPath: indexPath))
        return cell
    }
}

extension MoviesListViewController: UICollectionViewDelegate {
    
}

extension MoviesListViewController: MovieListViewProtocol {
    
    func loadingFinished(with indicies: [IndexPath]) {
        self.collectionView.insertItems(at: indicies)
    }
    
    func hideActivity() {
        // remove activity
    }
    
    func showActivity() {
        // display activity
    }
}
