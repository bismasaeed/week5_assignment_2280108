import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:persist_data/todolist.dart';

void main() {
  group('TodoApp Unit Tests', () {
    test('addTask should add a new task to the list', () {
      final appState = TodoAppState();
      appState.addTask('New Task', isTest: true);
      expect(appState.tasks.length, 1);
      expect(appState.tasks[0]['task'], 'New Task');
      expect(appState.tasks[0]['completed'], false);
    });

    test('Mocked SharedPreferences - loadTasks should load tasks', () async {
      final Map<String, Object> values = {
        'task': json.encode([
          {'task': 'Mocked Task', 'completed': false}
        ])
      };
      SharedPreferences.setMockInitialValues(values);
      final appState = TodoAppState();
      await appState.loadTasks(isTest: true);
      expect(appState.tasks.length, 1);
      expect(appState.tasks[0]['task'], 'Mocked Task');
      expect(appState.tasks[0]['completed'], false);
    });
  });
}
