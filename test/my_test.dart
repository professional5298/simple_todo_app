// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/base/module/todo.dart';
import 'package:todo_app/features/todo/action.dart';
import 'package:todo_app/features/todo/todo_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // Use command "flutter run test/my_test.dart" in terminal to test
  group('Todo Service', () {
    test('Test Insert Todo', () async {
      Todo insertTodo = await TodoService.db
          .insert(DoInsertTodoAction(Todo(title: 'Test Insert Todo', done: false)));
      expect(insertTodo.title, 'Test Insert Todo');
      expect(insertTodo.done, false);
      expect(insertTodo.date, null);
    });
    test('Test update Todo', () async {
      List<Todo> listTodo = await TodoService.db.getTodo();

      DateTime now = DateTime.now();

      listTodo.first.done = true;
      listTodo.first.date = now;

      int updateTodo = await TodoService.db.update(DoUpdateTodoAction(listTodo.first));
      expect(updateTodo, 1);
    });
    test('Test delete Todo', () async {
      List<Todo> listTodo = await TodoService.db.getTodo();
      int deleteTodo = await TodoService.db.delete(listTodo.first.id);
      expect(deleteTodo, 1);
    });
  });

  group('Todo module test', () {
    test('Todo from map', () {
      Todo todo = Todo.fromMap({
        'id': 5,
        'title': 'Test Todo from map',
        'done': false,
        'date': null,
      });
      expect(todo.id, 5);
      expect(todo.title, 'Test Todo from map');
      expect(todo.done, false);
      expect(todo.date, null);
    });

    test('Todo to map', () {
      Todo todo = Todo(id: 4, title: 'Test Todo to map', done: true, date: null);
      Map todoMap = todo.toMap();
      expect(todoMap['id'], 4);
      expect(todoMap['title'], 'Test Todo to map');
      expect(todoMap['done'], 1);
      expect(todoMap['date'], null);
    });
  });
}
