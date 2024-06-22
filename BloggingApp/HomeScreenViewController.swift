//
//  HomeScreenViewController.swift
//  BloggingApp
//
//  Created by Devank on 22/06/24.
//

import UIKit
import FirebaseFirestore


class HomeScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
       var blogs: [Blog] = []

       override func viewDidLoad() {
           super.viewDidLoad()
           
           // Set up the navigation bar
           navigationController?.navigationBar.prefersLargeTitles = true
           navigationItem.title = "Blogs"
           
           let writeButton = UIBarButtonItem(title: "Write Blog", style: .plain, target: self, action: #selector(writeBlogButtonTapped))
           navigationItem.rightBarButtonItem = writeButton

           setupTableView()
           fetchBlogs()
       }

       override func viewDidAppear(_ animated: Bool) {
           fetchBlogs()
           super.viewDidAppear(animated)
           self.view.backgroundColor = .white
       }

       func setupTableView() {
           tableView = UITableView()
           tableView.delegate = self
           tableView.dataSource = self
           tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BlogCell")

           tableView.translatesAutoresizingMaskIntoConstraints = false
           self.view.addSubview(tableView)
           
           NSLayoutConstraint.activate([
               tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
               tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
               tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
               tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
           ])
       }

       @objc func writeBlogButtonTapped() {
           let writeVC = WriteBloggingViewController()
           self.navigationController?.pushViewController(writeVC, animated: true)
       }

    
    func fetchBlogs() {
        let db = Firestore.firestore()
        db.collection("blogs").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.blogs = []
                for document in querySnapshot!.documents {
                    let data = document.data()
                    print("Document data: \(data)") // Debug print to check the structure
                    if let title = data["title"] as? String,
                       let content = data["content"] as? String,
                       let timestamp = data["timestamp"] as? Timestamp,  // Parse timestamp as FIRTimestamp
                       let authorId = data["authorId"] as? String {
                        let date = timestamp.dateValue()  // Convert FIRTimestamp to Date
                        let dateString = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .short)  // Convert Date to String
                        let blog = Blog(title: title, content: content, author: authorId, timestamp: dateString)
                        print("Fetched blog: \(blog)") // Debug print
                        self.blogs.append(blog)
                    } else {
                        print("Error parsing document: \(document.documentID)") // Debug print to identify parsing issues
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }


       // MARK: - UITableViewDataSource Methods

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return blogs.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "BlogCell", for: indexPath)
           let blog = blogs[indexPath.row]
           cell.textLabel?.text = "\(blog.title) - \(blog.timestamp) - \(blog.content)"
           return cell
       }
}


// cell.textLabel?.text = "\(blog.title) - \(blog.timestampToString())  - \(blog.content)"



