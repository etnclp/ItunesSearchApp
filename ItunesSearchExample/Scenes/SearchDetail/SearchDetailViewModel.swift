//
//  SearchDetailViewModelswift.swift
//  ItunesSearchExample
//
//  Created by Erdi Tunçalp on 13.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Foundation

typealias SearchDetailChangeHandler = (SearchDetailState.Change) -> Void

struct SearchDetailState {

    private(set) var searchResult: SearchResult

    var cells: [SpecialCell.Type] {
        switch self.searchResult.kind {
        case .featureMovie:
            return [MovieCell.self, AboutCell.self]
        default:
            return [SongCell.self]
        }
    }

    enum Change {
        case showProgress
        case hideProgress
    }
}

class SearchDetailViewModel {

    var stateChangeHandler: SearchDetailChangeHandler?
    private(set) var state: SearchDetailState

    init(state: SearchDetailState) {
        self.state = state
    }

    // MARK: - Public Methods

    func numberOfItems() -> Int {
        return state.cells.count
    }

    func viewModelForRow(index: Int) -> SearchDetailCellViewProtocol? {
        return SearchDetailCellViewModel(searchResult: state.searchResult)
    }

    // MARK: - Actions

    private func emit(_ state: SearchDetailState.Change) {
        stateChangeHandler?(state)
    }

}
