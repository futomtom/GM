// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let commit = try? newJSONDecoder().decode(Commit.self, from: jsonData)

import Foundation

// MARK: - CommitElement

struct CommitResponse: Codable, Hashable {
    static func == (lhs: CommitResponse, rhs: CommitResponse) -> Bool {
        lhs.sha == rhs.sha
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(sha)
    }

    let sha: String
    let commit: Commit
}

// MARK: - CommitCommit

struct Commit: Codable {
    let author, committer: Author
    let message: String
}

struct Author: Codable {
    let name: String
}
