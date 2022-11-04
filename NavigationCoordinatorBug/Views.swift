//
//  ContentView.swift
//  NavigationCoordinatorBug
//
//  Created by Jason Ji on 11/3/22.
//

import SwiftUI

struct AppView: View {
    /// Only one of the two below should be used (ScreenCoordinator.navigationStack or @State navigationStack).
    /// The bug occurs in both cases.
    @StateObject var coordinator: ScreenCoordinator
    @State var navigationStack: [Screen] = [.firstDetail]
    
    init() {
        _navigationStack = State(initialValue: [.firstDetail])
        self._coordinator = StateObject(wrappedValue: ScreenCoordinator(screens: [.firstDetail]))
    }
    
    var body: some View {
        /// Here is the heart of the bug. Inside a `TabView`, a `NavigationStack` holds a binding to a `[Screen]` array.
        /// If that `[Screen]` array lives inside of a `StateObject`, the NavigationStack itself gets corrupted shortly after initialization.
        /// Specifically, although it's being initialized with one `Screen` value, it gets reset to an empty array.
        /// That doesn't happen if there is no `TabView`.
        TabView {
            NavigationStack(path: $navigationStack) {
                RootView()
                    .navigationDestination(for: Screen.self) { screen in
                        switch screen {
                        case .root:
                            RootView()
                        case .firstDetail:
                            FirstDetailView()
                        case .secondDetail:
                            SecondDetailView()
                        case .thirdDetail:
                            ThirdDetailView()
                        }
                    }
            }
            .tabItem { Label("Cool Tab", systemImage: "rectangle.stack") }
            .tag(0)
        }
    }
}

struct RootView: View {
    var body: some View {
        NavigationLink(value: Screen.firstDetail) {
            Text("Push first detail")
        }
        .navigationTitle("Root View")
    }
}

struct FirstDetailView: View {
    var body: some View {
        NavigationLink(value: Screen.secondDetail) {
            Text("Push second detail")
        }
        .navigationTitle("First Detail")
    }
}

struct SecondDetailView: View {
    var body: some View {
        NavigationLink(value: Screen.thirdDetail) {
            Text("Push third detail")
        }
        .navigationTitle("Second Detail")
    }
}

struct ThirdDetailView: View {
    var body: some View {
        Text("Now pop back twice.")
            .navigationTitle("Third Detail")
    }
}

