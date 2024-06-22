//
//  ViewController.swift
//  BloggingApp
//
//  Created by Devank on 22/06/24.
//

import UIKit
import FirebaseAuth
import Firebase

class ViewController: UIViewController {

    let emailTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Email"
            textField.borderStyle = .roundedRect
            return textField
        }()

        let passwordTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
            textField.borderStyle = .roundedRect
            return textField
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            setupViews()
        }

        func setupViews() {
            let signInButton = UIButton(type: .system)
            signInButton.setTitle("Sign In", for: .normal)
            signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)

            let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, signInButton])
            stackView.axis = .vertical
            stackView.spacing = 10
            stackView.translatesAutoresizingMaskIntoConstraints = false

            view.addSubview(stackView)
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
        }

    
    
  

    
    
        @objc func signInButtonTapped() {
            guard let email = emailTextField.text, let password = passwordTextField.text else {
                return
            }

            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let self = self else { return }
                if let error = error {
                    print("Sign in error: \(error.localizedDescription)")
                    // Handle sign-in error
                    return
                }
                // Navigate to home screen
                let homeVC = HomeScreenViewController()
                        homeVC.modalPresentationStyle = .fullScreen
                       // self.present(homeVC, animated: true, completion: nil)
                self.navigationController?.pushViewController(homeVC, animated: true)
       
            }
        }
    
}

