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
        self.collectionView.register(supplementaryViewType: MovieListCollectionFooterView.self, ofKind: UICollectionView.elementKindSectionFooter)
    }
    
    private func configureFlowLayout() {
        if let layout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath, viewType: MovieListCollectionFooterView.self)
            return footerView
        }
        return UICollectionReusableView()
    }
}

extension MoviesListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.presenter?.getMovies()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let presenter = self.presenter else { return CGSize.zero }
        return presenter.isPageLoadingRequired() ? CGSize(width: self.collectionView.frame.width, height: 50) : CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.didSelectMovie(at: indexPath)
    }
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
        self.removeActivity()
    }
    
    func removeActivity() {
        // remove activity
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func failed(withError error: MarsplayError?) {
        self.removeActivity()
        self.showAlert(title: "Error", message: error?.errorDescription ?? "Something went wrong. Please try again later.") { (alert, index) in
        }
    }
}
