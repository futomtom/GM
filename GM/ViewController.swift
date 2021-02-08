//
//  ViewController.swift
//  GM
//
//  Created by Alex Fu on 2/6/21.
//

import Combine
import UIKit

class ViewController: UIViewController {
    enum Section {
        case main
    }

    @IBOutlet var collectionView: UICollectionView!

    private var viewModel = ViewModel()
    private var cancellables: Set<AnyCancellable> = []
    private var datasource: UICollectionViewDiffableDataSource<Section, CommitResponse>!
    var page = 0

    let loadingIndicator: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView(style: .medium)
        v.hidesWhenStopped = true
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchData()
    }

    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: config)
    }

    private func configureCollectionView() {
        collectionView.collectionViewLayout = createLayout()
        datasource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, commit) -> UICollectionViewCell? in

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "cell",
                for: indexPath
            ) as? CommitCollectionViewCell
            cell?.configure(with: commit)
            return cell
        })
    }

    private func fetchData() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.loadingIndicator.startAnimating()
                } else {
                    self?.loadingIndicator.stopAnimating()
                }
            }
            .store(in: &cancellables)

        viewModel.dataChanged
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateSnapshot()
            }
            .store(in: &cancellables)

        viewModel.fetchCommits(page: page)
    }

    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CommitResponse>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.commits, toSection: .main)
        datasource.apply(snapshot)
    }
}

// https://api.github.com/repos/apple/swift/commits?page=0
// https://api.github.com/repos/apple/swift/commits?page=1
// not sure why github pagation return same response/

/*
 extension ViewController: UICollectionViewDelegate {
     func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         guard !viewModel.isLoading else { return }
         if  indexPath.row == viewModel.commits.count - 1 {
             page += 1
             viewModel.fetchCommits(page: page)
         }
     }
 }
  */
