//
//  SearchDetailCellViewModel.swift
//  ItunesSearchExample
//
//  Created by Erdi Tunçalp on 17.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Foundation

protocol SearchDetailCellViewProtocol {
    var imageUrl: String? { get }
    var collectionCensoredName: String? { get }
    var primaryGenreName: String? { get }
    var trackCount: String? { get }
    var releaseDate: String? { get }
    var collectionPrice: String? { get }

    var trackName: String? { get }
    var contentAdvisoryRating: String? { get }
    var rentalPrice: String? { get }
    var movieCollectionPrice: String? { get }
    var longDescription: String? { get }
}

class SearchDetailCellViewModel: SearchDetailCellViewProtocol {
    var imageUrl: String?
    var collectionCensoredName: String?
    var primaryGenreName: String?
    var trackCount: String?
    var releaseDate: String?
    var collectionPrice: String?

    var trackName: String?
    var contentAdvisoryRating: String?
    var rentalPrice: String?
    var movieCollectionPrice: String?
    var longDescription: String?

    init(searchResult: SearchResult?) {
        imageUrl = searchResult?.artworkUrl100

        collectionCensoredName = searchResult?.collectionCensoredName
        primaryGenreName = searchResult?.primaryGenreName
        trackCount = "\(searchResult?.trackCount ?? 0) Items"
        releaseDate = searchResult?.releaseDate
        collectionPrice = "\(searchResult?.collectionPrice ?? 0) \(searchResult?.currency ?? "")"

        trackName = searchResult?.trackName
        contentAdvisoryRating = searchResult?.contentAdvisoryRating
        rentalPrice = "\(searchResult?.trackRentalPrice ?? 0) \(searchResult?.currency ?? "") RENT"
        movieCollectionPrice = "\(searchResult?.collectionPrice ?? 0) \(searchResult?.currency ?? "") BUY"

        longDescription = searchResult?.longDescription
    }

}
