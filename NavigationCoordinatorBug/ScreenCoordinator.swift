//
//  ScreenCoordinator.swift
//  NavigationCoordinatorBug
//
//  Created by Jason Ji on 11/3/22.
//

import SwiftUI

enum Screen: Hashable {
    case root, firstDetail, secondDetail, thirdDetail
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
    
    init(screens: [Screen] = []) {
        self.navigationStack = screens
        print("init navigationStack: \(navigationStack)")
    }
}
