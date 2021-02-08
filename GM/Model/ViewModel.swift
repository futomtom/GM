//
//  ViewModel.swift
//  GM
//
//  Created by Alex Fu on 2/6/21.
//
import Combine
import Foundation
import UIKit

final class ViewModel: NSObject {
    private(set) var dataChanged = PassthroughSubject<Void, Never>()
    @Published var isLoading = false

    private let api = GithubAPI()
    private var cancellables = Set<AnyCancellable>()

    var commits = [CommitResponse]()

    func fetchCommits(page: Int = 0) {
        isLoading = true
        let commitPublisher = api.commitPublisher(page: page).sink { _ in
            self.isLoading = false
        } receiveValue: { commits in
            self.isLoading = false
            self.commits.append(contentsOf: commits)
            self.dataChanged.send()
        }
        .store(in: &cancellables)
    }
}
