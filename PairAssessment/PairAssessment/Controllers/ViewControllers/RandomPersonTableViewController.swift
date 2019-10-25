//
//  RandomPersonTableViewController.swift
//  PairAssessment
//
//  Created by Austin Goetz on 10/25/19.
//  Copyright © 2019 Austin Goetz. All rights reserved.
//

import UIKit

class RandomPersonTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PersonController.shared.loadFromPersistentStore()
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Person", message: "Add someone new to the list", preferredStyle: .alert)
        
        let addButton = UIAlertAction(title: "Add", style: .default) { (action) in
            guard let newPerson = alert.textFields?[0].text else { return }
            PersonController.shared.addPerson(name: newPerson)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Full Name"
            textField.autocorrectionType = .yes
            textField.autocapitalizationType = .words
        }
        alert.addAction(addButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true)
    }
    
    @IBAction func randomizeButtonTapped(_ sender: UIButton) {
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.shared.people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        let personToDisplay = PersonController.shared.people[indexPath.row]
        
        cell.textLabel?.text = personToDisplay.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let personToDelete = PersonController.shared.people[indexPath.row]
            PersonController.shared.deletePerson(person: personToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
