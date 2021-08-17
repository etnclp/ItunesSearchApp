//
//  SearchResultViewModel.swift
//  ItunesSearchExample
//
//  Created by Erdi Tunçalp on 13.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Foundation

typealias SearchResultChangeHandler = (SearchResultState.Change) -> Void

struct SearchResultState {

    fileprivate var searchQuery: String = ""
    fileprivate var searchResults: [SearchResult] = []
    fileprivate var mediaType: MediaType = .all
    fileprivate var offset: Int = 0
    fileprivate var hasNextPage: Bool = true
    fileprivate let limit: Int = 10

    enum Change {
        case showProgress
        case hideProgress
        case reloadData
        case noResult(String)
        case itemSelected(SearchResult)
        case errorOccurred(String)
    }
}

class SearchResultViewModel {

    var stateChangeHandler: SearchResultChangeHandler?
    private(set) var state: SearchResultState

    init(state: SearchResultState) {
        self.state = state
    }

    // MARK: - Public Methods

    func numberOfItems() -> Int {
        return state.searchResults.count
    }

    func viewModelForRow(index: Int) -> SearchResultCellViewProtocol? {
        return SearchResultCellViewModel(searchResult: state.searchResults[index])
    }

    func didSelectItem(index: Int) {
        emit(.itemSelected(state.searchResults[index]))
    }

    func searchTextDidChange(query: String?) {
        guard let keyword = query, keyword.count > 2 else {
            state.searchResults.removeAll()
            self.emit(.reloadData)
            return
        }
        state.offset = 0
        self.searchAsset(keyword: keyword)
    }

    func changeMediaType(_ mediaType: MediaType) {
        state.mediaType = mediaType
        state.offset = 0
        searchAsset(keyword: state.searchQuery)
    }

    func fetchNewData() {
        guard state.searchResults.count >= state.limit else { return }
        state.offset += state.limit
        searchAsset(keyword: state.searchQuery)
    }

    // MARK: - Actions

    private func searchAsset(keyword: String) {
        emit(.showProgress)
        let request = SearchRequest(query: keyword, media: state.mediaType.rawValue, offset: state.offset)
        NetworkManager.shared.execute(request: request) { [weak self] response in
            guard let self = self else { return }
            self.emit(.hideProgress)
            switch response.result {
            case .success(let result):
                if let results = result.results {
                    self.handle(results: results, keyword: keyword)
                }
            case .failure(let error):
                log.error(error)
                self.emit(.errorOccurred(error.localizedDescription))
            }
        }
    }

    private func handle(results: [SearchResult], keyword: String) {
        state.searchQuery = keyword
        if state.offset == 0 {
            state.searchResults.removeAll()

            if results.count == 0 {
                emit(.noResult(keyword))
                return
            }
        }

        state.searchResults += results
        emit(.reloadData)
    }

    private func emit(_ state: SearchResultState.Change) {
        stateChangeHandler?(state)
    }

}
