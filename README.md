# Infinite Scrolling List Example

This Flutter project demonstrates the implementation of an infinite scrolling list using `ListView.builder` and a `ScrollController` to detect when the user has scrolled near the bottom of the list, triggering an API call to load more data.

## Features

- Infinite scrolling list that loads data dynamically as the user scrolls.
- Mock API simulates fetching data in pages.
- Displays a floating action button to scroll back to the top when the user scrolls down.
- Smooth scroll animation when navigating back to the top.
- Clean state management using `ChangeNotifier` and `Provider`.

## Project Structure

### `InfiniteScrollList`
The main UI component that handles the list display and interaction.

- Listens to scroll events using a `ScrollController`.
- Triggers data loading when the user scrolls past a certain point.
- Displays a floating action button to quickly return to the top of the list.

### `AppState`
Manages the state of the app, including:

- Current list of data (`intList`).
- Loading state to indicate when more data is being fetched.
- Pagination logic to load data in chunks.
- Floating action button visibility based on scroll position.

### `API`
Simulates a backend API call that returns a list of integers based on the page size and page number.

## Implementation

The app uses a `ScrollController` to monitor the user's scroll position. When the user scrolls past 70% of the total scrollable content, the app calls the `appendList()` function in `AppState` to fetch more data from the API.

The app also uses a `FloatingActionButton` that appears when the user scrolls down and allows for quick navigation back to the top of the list.

## Getting Started

### Prerequisites
- Flutter SDK installed on your machine.
- Basic knowledge of `Provider` and state management in Flutter.

### How to run

1. Clone this repository.
2. Run `flutter pub get` to fetch dependencies.
3. Run `flutter run` to start the app.

### Key Components

#### ScrollController
Used to detect scroll position and trigger the API call for fetching more data.

#### ChangeNotifier & Provider
`AppState` extends `ChangeNotifier` and is provided at the top level of the widget tree to manage the app’s state.

### Example Code

#### Infinite Scroll Listener
```dart
_controller.addListener(() {
  if (_controller.offset > _controller.position.maxScrollExtent * 0.7) {
    appState.appendList();
  }
});
```
### Conclusion

This project showcases how to implement infinite scrolling in Flutter using `ListView.builder`, `ScrollController`, and a mock API. It provides a simple yet effective approach for managing dynamic data loading in a paginated format.