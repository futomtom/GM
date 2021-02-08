//
//  GithubAPI.swift
//  GM
//
//  Created by Alex Fu on 2/7/21.
//

import Combine
import Foundation

struct GithubAPI {
    let baseURL = "https://api.github.com/repos/Alamofire/Alamofire/commits"
    let session = URLSession.shared
    let decoder: JSONDecoder

    init() {
        decoder = JSONDecoder()
    }

    func commitPublisher(page: Int = 0) -> AnyPublisher<[CommitResponse], Error> {
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.queryItems = [URLQueryItem(name: "page", value: String(page))]

        return session.dataTaskPublisher(for: urlComponents.url!)
            .map { $0.data }
            .decode(type: [CommitResponse].self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
