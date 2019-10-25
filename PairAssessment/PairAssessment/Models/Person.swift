//
//  Person.swift
//  PairAssessment
//
//  Created by Austin Goetz on 10/25/19.
//  Copyright © 2019 Austin Goetz. All rights reserved.
//

import Foundation

class Person {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
    }
}
