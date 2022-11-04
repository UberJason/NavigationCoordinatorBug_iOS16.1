//
//  ContentView.swift
//  NavigationCoordinatorBug
//
//  Created by Jason Ji on 11/3/22.
//

import SwiftUI

struct RootView: View {
    @StateObject var coordinator: ScreenCoordinator
    @State var navigationStack = [Screen]()
    
    init() {
        let currentPlan = MealStore.shared.currentPlan()
        _navigationStack = State(initialValue: [.planDetail(planId: currentPlan.id)])
        self._coordinator = StateObject(wrappedValue: ScreenCoordinator(screens: [.planDetail(planId: currentPlan.id)]))
    }
    
    /// Here is the heart of the bug. A `NavigationStack` holds a binding to a `[Screen]` array.
    /// If that `[Screen]` array lives inside of a `StateObject`, the NavigationStack itself gets corrupted shortly after initialization.
    /// Specifically, although it's being initialized with one `Screen` value, it gets reset to an empty array.
    /// That doesn't happen if the `[Screen]` array lives directly in `State`.
    ///
    var body: some View {
        TabView {
            NavigationStack(path: $coordinator.navigationStack) {
                AllPlansView()
                    .navigationDestination(for: Screen.self) { screen in
                        coordinator.makeDestination(for: screen)
                    }
            }
            .tabItem { Label("Plans", systemImage: "rectangle.stack") }
            .tag(0)
        }
    }
}

struct AllPlansView: View {
    var body: some View {
        NavigationLink(value: Screen.planDetail(planId: MealStore.shared.currentPlan().id)) {
            Text("Push plan")
        }
        .navigationTitle("All Plans")
    }
}

struct PlanDetailsView: View {
    let plan: Plan
    
    var body: some View {
        NavigationLink(value: Screen.entryDetail(entryId: plan.entries.first!.id)) {
            Text("Push entry")
        }
        .navigationTitle("Plan Details")
    }
}

struct EntryDetailsView: View {
    let entry: Entry
    
    var body: some View {
        NavigationLink(value: Screen.recipeDetail(recipeId: entry.recipes.first!.id)) {
            Text("Push Recipe")
        }
        .navigationTitle("Entry Details")
    }
}

struct RecipeDetailsView: View {
    let recipe: Recipe
    
    var body: some View {
        Text("This is a recipe.")
            .navigationTitle("Recipe Details")
    }
}

