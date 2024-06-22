//
//  PostBlogViewController.swift
//  BloggingApp
//
//  Created by Devank on 22/06/24.
//

import UIKit
import FirebaseFirestore

struct Blog: Codable {
    var title: String
    var content: String
    var author: String
    var timestamp: String
}

class PostBlogViewController: UIViewController {

    var blog: Blog

        init(blog: Blog) {
            self.blog = blog
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            let titleLabel = UILabel()
            titleLabel.text = blog.title
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(titleLabel)

            let contentLabel = UILabel()
            contentLabel.text = blog.content
            contentLabel.numberOfLines = 0
            contentLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(contentLabel)

            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

                contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
                contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ])
        }

}
