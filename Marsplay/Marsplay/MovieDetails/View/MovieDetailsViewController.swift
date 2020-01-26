//
//  MovieDetailsViewController.swift
//  Marsplay
//
//  Created by Amol Prakash on 27/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    var presenter: MovieDetailsPresenterProtocol?
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
}

extension MovieDetailsViewController: MovieDetailsViewProtocol {
    
    func displayUI(for movie: Movie?) {
        self.titleLabel.text = movie?.title
        self.yearLabel.text = movie?.yearsAgo
        self.typeLabel.text = movie?.type?.rawValue.capitalized
        self.posterImageView.setImage(with: movie?.poster, placeHolder: UIImageView.placeHolderImage)
    }
}
