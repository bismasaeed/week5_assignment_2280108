import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatefulWidget {
  @override
  TodoAppState createState() => TodoAppState();
}

class TodoAppState extends State<TodoApp> {
  List<Map<String, dynamic>> tasks = [];
  TextEditingController taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('task', json.encode(tasks));
  }

  void addTask(String task, {bool isTest = false}) {
    if (task.isNotEmpty) {
      tasks.add({'task': task, 'completed': false});
      taskController.clear();
      if (!isTest) {
        setState(() {});
        saveTasks();
      }
    }
  }

  Future<void> loadTasks({bool isTest = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasksString = prefs.getString('task');
    if (tasksString != null) {
      tasks = List<Map<String, dynamic>>.from(json.decode(tasksString));
    }
    if (!isTest) {
      setState(() {});
    }
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index]['completed'] = !tasks[index]['completed'];
      saveTasks();
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
      saveTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('To-Do List')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: taskController,
                      decoration: InputDecoration(hintText: 'Enter task'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => addTask(taskController.text),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: tasks[index]['completed'],
                      onChanged: (value) => toggleTask(index),
                    ),
                    title: Text(tasks[index]['task']),
                    trailing: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => deleteTask(index),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
