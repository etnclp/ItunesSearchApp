//
//  SongCell.swift
//  ItunesSearchExample
//
//  Created by Erdi Tunçalp on 13.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import UIKit

class SongCell: SearchDetailCell, SpecialCell {
    
    // MARK: - Properties
    
    static var Height: CGFloat = 123
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var genreNameLabel: UILabel!
    @IBOutlet weak var trackCountLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var collectionPriceLabel: UILabel!

    // MARK: - Configure
    
    override func configure(_ viewProtocol: SearchDetailCellViewProtocol) {
        songImageView.setImage(url: viewProtocol.imageUrl)
        titleLabel.text = viewProtocol.collectionCensoredName
        genreNameLabel.text = viewProtocol.primaryGenreName
        trackCountLabel.text = viewProtocol.trackCount
        releaseDateLabel.text = viewProtocol.releaseDate
        collectionPriceLabel.text = viewProtocol.collectionPrice
    }
    
}
