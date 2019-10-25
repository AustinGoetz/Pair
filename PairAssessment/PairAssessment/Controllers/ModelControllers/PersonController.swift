//
//  PersonController.swift
//  PairAssessment
//
//  Created by Austin Goetz on 10/25/19.
//  Copyright © 2019 Austin Goetz. All rights reserved.
//

import Foundation

class PersonController {
    
    // MARK: - Shared Instance/Singleton
    static let shared = PersonController()
    
    // SoT
    var people: [Person] = []
    
    // MARK: - CRUD Functions
    // Create
    func addPerson(name: String) {
        let newPerson = Person(name: name)
        people.append(newPerson)
        // Save to persistence
    }
    
    // Delete
    func deletePerson(person: Person) {
        guard let indexOfPersonToDelete = people.firstIndex(of: person) else { return }
        people.remove(at: indexOfPersonToDelete)
        // Save to persistence
    }
    
    // MARK: - Persistence
    
    // Create
    func createFileURLForPersistence() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let fileURL = urls[0].appendingPathComponent("PersonKeeperRunthrough.json")
        
        return fileURL
    }
    
    // Save
    func saveToPersistentStore() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let personJSON = try jsonEncoder.encode(people)
            try personJSON.write(to: createFileURLForPersistence())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    // Load
    func loadFromPersistentStore() {
        let jsonDecoder = JSONDecoder()
        
        do {
            let jsonData = try Data(contentsOf: createFileURLForPersistence())
            let decodedPeople = try jsonDecoder.decode([Person].self, from: jsonData)
            people = decodedPeople
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
}
