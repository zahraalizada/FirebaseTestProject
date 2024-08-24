//
//  ViewController.swift
//  FirebaseTestProject
//
//  Created by Zahra Alizada on 21.08.24.
//

import UIKit
import FirebaseFirestoreInternal

struct User: Decodable {
    let email: String?
    let firstName: String?
    let lastName: String?
    let cars: [String]?
}


class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    var items = [User]()
    let database = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
        getUsers()
    }
    
    func getUsers() {
        items.removeAll()
        database.collection("Users").getDocuments { snapshot, error in
            if let error {
                print(error.localizedDescription)
            } else if let snapshot {
                for document in snapshot.documents {
                    let dict = document.data()
                    if let jsonData = try? JSONSerialization.data(withJSONObject: dict) {
                        do {
                            let item = try JSONDecoder().decode(User.self, from: jsonData)
                            self.items.append(item)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
                self.table.reloadData()
            }
            
        }
        
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        let user = ["email": "tofiq\(items.count+1)@mail.ru",
                    "firstName": "Tofiq\(items.count+1)",
                    "lastName": "Todiqli\(items.count+1)" ]
        database.collection("Users").addDocument(data: user)
        getUsers()
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].email
        return cell
    }
    
    
}
