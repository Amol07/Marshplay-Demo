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
        self.title = "Movies"
        self.registerCells()
         self.configureFlowLayout()
        self.presenter?.viewDidLoad()
    }
    
    private func registerCells() {
        self.collectionView.register(cellType: MovieListCollectionViewCell.self)
    }
    
    private func configureFlowLayout() {
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
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

extension MoviesListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let column: CGFloat
        if UIApplication.shared.statusBarOrientation == .portrait || UIApplication.shared.statusBarOrientation == .portraitUpsideDown {
            column = 2.0
        } else {
            column = 3.0
        }
        var minimumInteritemSpacing = flowayout?.minimumInteritemSpacing ?? 0.0
        minimumInteritemSpacing = minimumInteritemSpacing * (column - 1.0)
        let space = (minimumInteritemSpacing) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size = (collectionView.frame.size.width - space) / column
        return CGSize(width: size, height: size*1.67)
    }
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
