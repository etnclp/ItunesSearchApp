//
//  SearchResultCellViewModel.swift
//  ItunesSearchExample
//
//  Created by Erdi Tunçalp on 13.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Foundation

protocol SearchResultCellViewProtocol {
    var title: String? { get }
    var imageUrl: String? { get }
    var kind: String? { get }
    var subtitle: String? { get }
}

class SearchResultCellViewModel: SearchResultCellViewProtocol {

    var title: String?
    var imageUrl: String?
    var kind: String?
    var subtitle: String?

    init(searchResult: SearchResult?) {
        self.title = searchResult?.trackName
        self.imageUrl = searchResult?.artworkUrl100
        self.kind = searchResult?.kind?.title
        self.subtitle = searchResult?.primaryGenreName
    }

}
