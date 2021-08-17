//
//  SearchResultCell.swift
//  ItunesSearchExample
//
//  Created by Erdi Tunçalp on 13.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell, SpecialCell {
    
    // MARK: - Properties
    
    static var Size: CGSize {
        get {
            let screenWidth = UIApplication.shared.windows.first?.safeAreaLayoutGuide.layoutFrame.width ?? UIScreen.main.bounds.width
            let width = (screenWidth > 800) ? (screenWidth - 55) / 2 : screenWidth
            return CGSize(width: width, height: 84)
        }
        set {}
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var kindLabel: UILabel!

    // MARK: - Configure

    func configure(_ viewProtocol: SearchResultCellViewProtocol) {
        artworkImageView.setImage(url: viewProtocol.imageUrl)
        titleLabel.text = viewProtocol.title
        kindLabel.text = viewProtocol.kind
        subtitleLabel.text = viewProtocol.subtitle
    }
    
}
