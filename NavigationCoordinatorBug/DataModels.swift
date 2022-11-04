//
//  DataModels.swift
//  NavigationCoordinatorBug
//
//  Created by Jason Ji on 11/3/22.
//

import Foundation

/// This is a 3-layer model consisting of "plans" which contain "entries" which contain "recipes".
struct Plan {
    let id: String
    let entries: [Entry]
}

struct Entry {
    let id: String
    let recipes: [Recipe]
}

struct Recipe {
    let id: String
}
