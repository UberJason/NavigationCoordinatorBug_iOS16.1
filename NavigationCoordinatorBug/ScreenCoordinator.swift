//
//  ScreenCoordinator.swift
//  NavigationCoordinatorBug
//
//  Created by Jason Ji on 11/3/22.
//

import SwiftUI

enum Screen: Hashable {
    case allPlans, planDetail(planId: String), entryDetail(entryId: String), recipeDetail(recipeId: String)
}

class ScreenCoordinator: ObservableObject {
    var navigationStack: [Screen] {
        willSet {
            print("navigationStack willSet: \(navigationStack), newValue: \(newValue)")
        }
        didSet {
            print("navigationStack didSet: \(navigationStack)")
        }
    }
    
    let store: MealStore
    
    init(store: MealStore = .shared, screens: [Screen] = []) {
        self.store = store
        self.navigationStack = screens
        print("init navigationStack: \(navigationStack)")
    }

    @ViewBuilder
    func makeDestination(for screen: Screen) -> some View {
        switch screen {
        case .allPlans:
            AllPlansView()
        case .planDetail(let planId):
            let plan = store.plan(with: planId)
            PlanDetailsView(plan: plan)
        case .entryDetail(let entryId):
            let entry = store.entry(with: entryId)
            EntryDetailsView(entry: entry)
        case .recipeDetail(let recipeId):
            let recipe = store.recipe(with: recipeId)
            RecipeDetailsView(recipe: recipe)
        }
    }
}
