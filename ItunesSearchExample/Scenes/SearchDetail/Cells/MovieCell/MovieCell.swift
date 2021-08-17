//
//  MovieCell.swift
//  ItunesSearchExample
//
//  Created by Erdi Tunçalp on 13.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import UIKit

class MovieCell: SearchDetailCell, SpecialCell {
    
    // MARK: - Properties
    
    static var Height: CGFloat = 123
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var advisoryRatingLabel: UILabel!
    @IBOutlet weak var rentalPriceLabel: UILabel!
    @IBOutlet weak var collectionPriceLabel: UILabel!

    // MARK: - Configure

    override func configure(_ viewProtocol: SearchDetailCellViewProtocol) {
        movieImageView.setImage(url: viewProtocol.imageUrl)
        titleLabel.text = viewProtocol.trackName
        advisoryRatingLabel.text = viewProtocol.contentAdvisoryRating
        rentalPriceLabel.text = viewProtocol.rentalPrice
        collectionPriceLabel.text = viewProtocol.movieCollectionPrice
    }

}
