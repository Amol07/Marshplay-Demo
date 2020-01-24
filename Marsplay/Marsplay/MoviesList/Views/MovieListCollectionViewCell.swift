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
    @IBOutlet private weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.cornerRadius = 5
        self.containerView.layer.borderColor = UIColor.clear.cgColor
        self.containerView.layer.masksToBounds = true
    }
    
    func configureCell(withMovie movie: Movie) {
        self.titleLabel.text = movie.title
        self.yearLabel.text = movie.yearsAgo
        self.typeLabel.text = movie.type?.rawValue.capitalized
        self.activityIndicator.startAnimating()
        self.posterImageView.setImage(with: movie.poster, placeHolder: UIImageView.placeHolderImage) { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
}
