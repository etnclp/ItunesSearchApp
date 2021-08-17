//
//  SearchResultViewController.swift
//  ItunesSearchExample
//
//  Created by Erdi Tunçalp on 13.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import UIKit

class SearchResultViewController: BaseViewController {

    // MARK: - Properties

    private var viewModel = SearchResultViewModel(state: SearchResultState())
    private var pendingRequestWorkItem: DispatchWorkItem?

    // MARK: - IBOutlets

    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var noResultLabel: UILabel!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureViewModel()
    }


    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = SearchResultCell.Size
        }
    }

    // MARK: - Setup

    func configureViewModel() {
        viewModel.stateChangeHandler = { [weak self] (change) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch change {
                case .showProgress:
                    self.activityIndicator.startAnimating()
                case .hideProgress:
                    self.activityIndicator.stopAnimating()
                case .reloadData:
                    self.collectionView.isHidden = false
                    self.noResultLabel.isHidden = true
                    self.collectionView.reloadData()
                case .noResult(let keyword):
                    self.collectionView.isHidden = true
                    self.noResultLabel.isHidden = false
                    self.noResultLabel.text = "No results found for \"\(keyword)\"."
                case .itemSelected(let result):
                    self.routeToSearchDetail(searchResult: result)
                case .errorOccurred(let message):
                    self.showAlert(message: message)
                }
            }
        }
    }

    private func setupUI() {
        self.title = "Search"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filter"), style: .done, target: self, action: #selector(filterButtonTapped))

        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.isTranslucent = false
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = SearchResultCell.Size
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        flowLayout.minimumLineSpacing = 15
        flowLayout.minimumInteritemSpacing = 15
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        collectionView.dataSource = self
        collectionView.delegate = self
        SearchResultCell.register(to: collectionView)
    }

    private func routeToSearchDetail(searchResult: SearchResult) {
        let vc = SearchDetailViewController(searchResult: searchResult)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Actions

    @objc private func filterButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: nil, message: "Filter", preferredStyle: .actionSheet)
        MediaType.allCases.forEach { (mediaType) in
            alert.addAction(
                UIAlertAction(
                    title: mediaType.title,
                    style: .default,
                    handler: { _ in
                        self.viewModel.changeMediaType(mediaType)
                        self.title = "Search " + mediaType.navTitle
                    }
                )
            )
        }
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = [] 
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

// MARK: - UICollectionViewDataSource

extension SearchResultViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SearchResultCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)

        if let viewModel = viewModel.viewModelForRow(index: indexPath.row) {
            cell.configure(viewModel)
        }

        return cell
    }

}

// MARK: - UICollectionViewDelegate

extension SearchResultViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        viewModel.didSelectItem(index: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == collectionView.numberOfSections - 1 &&
            indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
            viewModel.fetchNewData()
        }
    }

}

// MARK: - UISearchResultsUpdating

extension SearchResultViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        pendingRequestWorkItem?.cancel()

        let requestWorkItem = DispatchWorkItem { [weak self] in
            self?.viewModel.searchTextDidChange(query: searchController.searchBar.text?.lowercased())
        }

        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250), execute: requestWorkItem)
    }

}
