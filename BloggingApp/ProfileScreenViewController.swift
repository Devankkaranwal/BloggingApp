//
//  ProfileScreenViewController.swift
//  BloggingApp
//
//  Created by Devank on 22/06/24.
//

import UIKit
import FirebaseAuth

class ProfileScreenViewController: UIViewController {

    let signOutButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Sign Out", for: .normal)
            button.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
            return button
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            setupViews()
        }

        func setupViews() {
            view.addSubview(signOutButton)
            signOutButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                signOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }

        @objc func signOutButtonTapped() {
            do {
                try Auth.auth().signOut()
                let signInVC = ViewController()
                signInVC.modalPresentationStyle = .fullScreen
                self.present(signInVC, animated: true, completion: nil)
            } catch let error {
                print("Failed to sign out: \(error.localizedDescription)")
            }
        }

}
