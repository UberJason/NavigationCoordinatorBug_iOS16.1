////
////  MealStore.swift
////  NavigationCoordinatorBug
////
////  Created by Jason Ji on 11/3/22.
////
//
//import Foundation
///// This is a simplified implementation of a real data store which would store multiple plans, each with multiple entries with multiple recipes.
///// In this simplified version, there's a single "current plan" with a single entry with a single recipe.
//class MealStore {
//    static let shared = MealStore()
//    private let _currentPlan = Plan(
//        id: "plan",
//        entries: [
//            Entry(
//                id: "entry",
//                recipes: [
//                    Recipe(id: "recipe")
//                ]
//            )
//        ]
//    )
//    
//    private init() {}
//    
//    func currentPlan() -> Plan {
//        _currentPlan
//    }
//    
//    func plan(with id: String) -> Plan {
//        _currentPlan
//    }
//    
//    func entry(with id: String) -> Entry {
//        _currentPlan.entries.first!
//    }
//    
//    func recipe(with id: String) -> Recipe {
//        _currentPlan.entries.first!.recipes.first!
//    }
//}
