# To-Do List App with Riverpod and Flutter Hooks

This is a simple to-do list app built using Flutter, Riverpod, and Flutter Hooks. The app allows users to add tasks, mark them as complete, and manage their to-do list efficiently.

## Features

- Add new tasks
- Display a list of tasks with their completion status
- Mark tasks as complete or incomplete using checkboxes
- Uses Riverpod for state management
- Utilizes Flutter Hooks for managing the text field controller

## Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/Sparsh327/web_reinvent_test.git
   ```
2. Navigate to the project directory:
   ```sh
   cd todo_list_riverpod
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the app:
   ```sh
   flutter run
   ```

## Dependencies

This project uses the following dependencies:

- `flutter_riverpod` for state management
- `hooks_riverpod` for integrating Flutter Hooks with Riverpod

## How It Works

- The `Task` model represents a task with a title and completion status.
- The `TaskNotifier` extends `StateNotifier<List<Task>>` to manage the list of tasks.
- `StateNotifierProvider` is used to expose the state to widgets.
- `HookConsumerWidget` is used in `ToDoScreen` to utilize `useTextEditingController()` for handling the input field.
- Users can add a task, which updates the state, and toggle its completion status using a checkbox.
