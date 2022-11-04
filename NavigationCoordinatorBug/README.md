# README

This sample project demonstrates a bug with NavigationStack(path:) when that path binding is derived from a StateObject or State.

The app has four layers - a root view, first detail view, second detail view, and third detail view. The intended behavior here is to launch the app directly into the first detail screen already pushed onto the navigation stack, and freely navigate around.

The app does indeed launch with the first detail screen pushed onto the stack, and you can drill down into second detail and third detail. However, if you pop back twice to first detail, it's *replaced* (not popped or pushed) on the stack by an second detail view instead.

The heart of the bug lies in `AppView`'s `NavigationStack`, which takes a path binding to a `[Screen]` array. If that `[Screen]` array lives inside of a `StateObject` or directly as `@State`, the NavigationStack itself gets corrupted shortly after initialization. (Specifically, although it's being initialized with one `Screen` value, it gets reset to an empty array.) Note that the `TabView` in `AppView` appears to be required for this bug - if there's no `TabView`, this bug doesn't occur.

For the `StateObject` case, this can be observed in the console print statements, where I print the first creation of the navigationStack in `init`, as well as the `willSet` and `didSet` calls for `ScreenCoordinator.navigationStack`. When you launch the app, the following will print:

```
init navigationStack: [NavigationCoordinatorBug.Screen.firstDetail]
navigationStack willSet: [NavigationCoordinatorBug.Screen.firstDetail], newValue: []
navigationStack didSet: []
```

The result is that the array representing the source of truth for the navigation stack is out of sync with the actual navigation stack on-screen, eventually causing a bug.

