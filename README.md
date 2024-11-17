# Flutter Todo App

A feature-rich, drag-and-drop enabled Todo application built with Flutter. This app allows users to manage tasks efficiently with a Kanban-style board interface.

## Features

- **Kanban Board**: Organize tasks in "To Do", "In Progress", and "Done" columns
- **Drag and Drop**: Easily move tasks between different status columns
- **Task Management**: Add, edit, and delete tasks
- **Due Dates**: Set and view due dates for tasks
- **Persistent Storage**: Tasks are stored locally using Hive database
- **Dark Mode**: Supports system-wide dark mode setting
- **Responsive Design**: Works on both mobile and tablet devices

## Screenshots

[Add your app screenshots here]

## Getting Started

### Prerequisites

- Flutter (Channel stable, 2.x.x or higher)
- Dart 2.x.x or higher

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/flutter-todo-app.git
   ```

2. Navigate to the project directory:
   ```
   cd flutter-todo-app
   ```

3. Get the dependencies:
   ```
   flutter pub get
   ```

4. Run the app:
   ```
   flutter run
   ```

## Project Structure

- `lib/`
  - `models/`: Contains the data models (e.g., TaskModel)
  - `providers/`: Contains state management logic (e.g., TaskProvider)
  - `views/`: Contains the main screens and modals
  - `widgets/`: Contains reusable widget components

## Dependencies

- `provider`: For state management
- `hive` and `hive_flutter`: For local data persistence
- `intl`: For date formatting
- `flutter_local_notifications`: For scheduling task reminders (to be implemented)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Thanks to the Flutter team for providing an excellent framework
- Inspired by various Kanban and Todo applications

## Future Enhancements

- [ ] Implement task search functionality
- [ ] Add task categories or tags
- [ ] Implement task priority levels
- [ ] Add user authentication and cloud sync
- [ ] Implement push notifications for due dates

## Contact

Mahmoud Faour - [https://www.linkedin.com/in/amwfa/](https://www.linkedin.com/in/amwfa/) - leedor97@gmail.com

Project Link: [https://github.com/mahmoudfa97/todo_app_flutter](https://github.com/mahmoudfa97/todo_app_flutter)