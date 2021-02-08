//
//  CommitCollectionViewCell.swift
//  GM
//
//  Created by Alex Fu on 2/7/21.
//

import UIKit

class CommitCollectionViewCell: UICollectionViewCell {
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var hashLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!

    func configure(with commit: CommitResponse) {
        authorLabel.text = commit.commit.author.name
        hashLabel.text = commit.sha
        messageLabel.text = commit.commit.message
    }
}
