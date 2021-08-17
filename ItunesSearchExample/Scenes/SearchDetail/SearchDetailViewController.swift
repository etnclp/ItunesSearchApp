//
//  SearchDetailViewController.swift
//  ItunesSearchExample
//
//  Created by Erdi Tunçalp on 13.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import UIKit

class SearchDetailViewController: BaseViewController {

    // MARK: - Properties

    private var viewModel: SearchDetailViewModel

    // MARK: - IBOutlets

    @IBOutlet weak private var tableView: UITableView!

    // MARK: - Initialization

    init(searchResult: SearchResult) {
        self.viewModel = SearchDetailViewModel(state: SearchDetailState(searchResult: searchResult))
        super.init()
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configureViewModel()
    }

    // MARK: - Setup

    private func configureViewModel() {
        viewModel.stateChangeHandler = { _ in }
    }

    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.state.cells.forEach({ $0.register(to: tableView) })
        navigationItem.largeTitleDisplayMode = .never
    }

}

// MARK: - UITableViewDataSource

extension SearchDetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = viewModel.state.cells[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.Identifier, for: indexPath)

        switch cell {
        case let searchDetailCell as SearchDetailCell:
            if let viewModel = viewModel.viewModelForRow(index: indexPath.row) {
                searchDetailCell.configure(viewModel)
            }
        default:
            break
        }

        return cell
    }

}

// MARK: - UITableViewDelegate

extension SearchDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.state.cells[indexPath.row].Height
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.state.cells[indexPath.row].EstimatedHeight
    }

}
