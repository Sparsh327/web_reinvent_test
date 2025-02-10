import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

// Task Model
class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}

// Riverpod State Provider
final tasksProvider = StateNotifierProvider<TaskNotifier, List<Task>>(
  (ref) => TaskNotifier(),
);

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  void addTask(String title) {
    state = [...state, Task(title: title)];
  }

  void toggleTask(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          Task(title: state[i].title, isCompleted: !state[i].isCompleted)
        else
          state[i]
    ];
  }

  void removeTask(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i]
    ];
  }
}

// Main App Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ToDoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// UI for To-Do List using Flutter Hooks
class ToDoScreen extends HookConsumerWidget {
  const ToDoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    final TextEditingController controller = useTextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('To-Do List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                        labelText: 'Task',
                        labelStyle: TextStyle(color: Colors.purple),
                        hintText: 'Enter task'),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        ref
                            .read(tasksProvider.notifier)
                            .addTask(controller.text);
                        controller.clear();
                      } else {
                        var snackBar = SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text('Please enter a task'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    label: Text('Add'),
                    icon: Icon(Icons.add))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.title),
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (_) =>
                        ref.read(tasksProvider.notifier).toggleTask(index),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.purple,
                    ),
                    onPressed: () =>
                        ref.read(tasksProvider.notifier).removeTask(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
