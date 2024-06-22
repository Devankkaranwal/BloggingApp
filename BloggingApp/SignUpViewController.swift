//
//  SignUpViewController.swift
//  BloggingApp
//
//  Created by Devank on 22/06/24.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

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

        let confirmPasswordTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Confirm Password"
            textField.isSecureTextEntry = true
            textField.borderStyle = .roundedRect
            return textField
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            setupViews()
        }

        func setupViews() {
            let signUpButton = UIButton(type: .system)
            signUpButton.setTitle("Sign Up", for: .normal)
            signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)

            let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, confirmPasswordTextField, signUpButton])
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

        @objc func signUpButtonTapped() {
            guard let email = emailTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text else {
                return
            }

            if password != confirmPassword {
                // Handle password mismatch
                return
            }

            Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                guard let self = self else { return }
                if let error = error {
                    print("Sign up error: \(error.localizedDescription)")
                    // Handle sign-up error
                    return
                }
                // Optionally sign in the user automatically
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        print("Sign in error: \(error.localizedDescription)")
                        // Handle sign-in error
                        return
                    }
                    // Navigate to home screen
//                    self.performSegue(withIdentifier: "HomeScreenViewController", sender: self)
                    let homeVC = HomeScreenViewController()
                            homeVC.modalPresentationStyle = .fullScreen
                         //   self.present(homeVC, animated: true, completion: nil)
                    self.navigationController?.pushViewController(homeVC, animated: true)
                    
                    
                }
            }
        }
}
