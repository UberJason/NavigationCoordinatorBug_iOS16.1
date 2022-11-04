# README

This sample project demonstrates a bug with NavigationStack(path:) when that path binding is derived from a StateObject rather than State.

The data layer is a 3-layer model consisting of "plans" which contain "entries" which contain "recipes". 

The UI layer matches - an "All Plans" screen, a "Plan Details" view, an "Entry Details" view, and a "Recipe Details" view.

The intended behavior here is to launch the app directly into the Plan Details screen already pushed onto the navigation stack, and freely navigate around.

The app does indeed launch with the Plan Details screen pushed onto the stack, and you can drill down into Entry Details and Recipe Details. However, if you pop back to Plan Details, it's replaced (not popped or pushed) on the stack by an Entry Details view instead.

The heart of the bug lies in `RootView`'s `NavigationStack`, which takes a path binding to a `[Screen]` array. If that `[Screen]` array lives inside of a `StateObject`, the NavigationStack itself gets corrupted shortly after initialization. (Specifically, although it's being initialized with one `Screen` value, it gets reset to an empty array.) That doesn't happen if the `[Screen]` array lives directly in `State`.

The result is that the array representing the source of truth for the navigation stack is out of sync with the actual navigation stack on-screen, eventually causing a bug.
