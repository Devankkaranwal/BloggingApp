//
//  WriteBloggingViewController.swift
//  BloggingApp
//
//  Created by Devank on 22/06/24.
//

import UIKit
import FirebaseFirestore
import Firebase

class WriteBloggingViewController: UIViewController {

    let titleTextField: UITextField = {
           let textField = UITextField()
           textField.placeholder = "Title"
           textField.borderStyle = .roundedRect
           return textField
       }()

       let contentTextView: UITextView = {
           let textView = UITextView()
           textView.layer.borderColor = UIColor.lightGray.cgColor
           textView.layer.borderWidth = 1
           textView.layer.cornerRadius = 5
           return textView
       }()

       let postButton: UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("Post", for: .normal)
           button.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
           return button
       }()

       override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = .white
           setupViews()
       }

       func setupViews() {
           let stackView = UIStackView(arrangedSubviews: [titleTextField, contentTextView, postButton])
           stackView.axis = .vertical
           stackView.spacing = 10
           stackView.translatesAutoresizingMaskIntoConstraints = false

           view.addSubview(stackView)
           NSLayoutConstraint.activate([
               stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
               stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               contentTextView.heightAnchor.constraint(equalToConstant: 200)
           ])
       }

       @objc func postButtonTapped() {
           guard let title = titleTextField.text, let content = contentTextView.text else { return }
           guard let currentUser = Auth.auth().currentUser else { return }

           let db = Firestore.firestore()
           db.collection("blogs").addDocument(data: [
               "title": title,
               "content": content,
               "timestamp": Timestamp(date: Date()),
               "authorId": currentUser.uid
           ]) { error in
               if let error = error {
                   print("Error adding document: \(error)")
               } else {
                   print("Document added successfully")
                   self.dismiss(animated: true, completion: nil)
               }
           }
       }
}
