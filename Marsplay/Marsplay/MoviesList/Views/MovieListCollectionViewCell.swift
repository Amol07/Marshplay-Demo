//
//  MovieListCollectionViewCell.swift
//  Marsplay
//
//  Created by Amol Prakash on 24/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell, Reusable, NibLoadable {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    func configureCell(withMovie movie: Movie) {
        self.titleLabel.text = movie.title
        self.yearLabel.text = movie.yearsAgo
        self.typeLabel.text = movie.type?.rawValue.capitalized
    }
}
