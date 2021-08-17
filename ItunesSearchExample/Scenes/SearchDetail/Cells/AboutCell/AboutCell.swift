//
//  AboutCell.swift
//  ItunesSearchExample
//
//  Created by Erdi Tunçalp on 13.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import UIKit

class AboutCell: SearchDetailCell, SpecialCell {
    
    // MARK: - Properties
    
    static var Height: CGFloat = UITableView.automaticDimension
    
    static var EstimatedHeight: CGFloat = 256
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!

    // MARK: - Configure

    override func configure(_ viewProtocol: SearchDetailCellViewProtocol) {
        descTextView.text = viewProtocol.longDescription
    }

}
