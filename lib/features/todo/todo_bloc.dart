import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:todo_app/base/module/todo.dart';
import 'package:todo_app/base/module/typedef.dart';
import 'package:todo_app/features/todo/action.dart';
import 'package:todo_app/features/todo/todo_data.dart';
import 'package:todo_app/features/todo/todo_service.dart';

class TodoBloc extends ChangeNotifier {
  final TodoData _todoData = new TodoData();

  TodoBloc() {
    onInitialize();
  }

  UnmodifiableListView<Todo> get listTodo =>
      UnmodifiableListView(List.unmodifiable(_todoData.mapTodo.values));

  void onInitialize() async {
    List<Todo> todo = await TodoService.db.getTodo();
    if (todo == null) return;
    if (todo.length != 0) {
      todo.forEach((element) {
        _todoData.mapTodo.addAll({element.id: element});
      });

      notifyListeners();
    }
  }

  UnmodifiableListView<Todo> get completeTodo {
    List<Todo> tempList = [];
    _todoData.mapTodo.forEach((key, value) {
      if (value.done) tempList.add(value);
    });
    return UnmodifiableListView(List.unmodifiable(tempList));
  }

  UnmodifiableListView<Todo> get incompleteTodo {
    List<Todo> tempList = [];
    _todoData.mapTodo.forEach((key, value) {
      if (!value.done) tempList.add(value);
    });
    return UnmodifiableListView(List.unmodifiable(tempList));
  }

  void insertTodo(DoInsertTodoAction action, {NextAction onDone}) async {
    Todo inserted = await TodoService.db.insert(action);
    _todoData.mapTodo.addAll({inserted.id: inserted});
    if (onDone != null) onDone(null);

    notifyListeners();
  }

  void updateTodo(DoUpdateTodoAction action,
      {NextAction onDone, NextAction onError}) async {
    int updated = await TodoService.db.update(action);
    if (updated != 0) {
      _todoData.mapTodo.update(action.todo.id, (value) => value = action.todo);
      if (onDone != null) onDone(null);

      notifyListeners();
    } else {
      if (onError != null) onError(null);
    }
  }

  void deleteTodo(DoDeleteTodoAction action,
      {NextAction onDone, NextAction onError}) async {
    int deleted = await TodoService.db.delete(action.todoId);
    if (deleted != 0) {
      _todoData.mapTodo.remove(action.todoId);
      if (onDone != null) onDone(null);

      notifyListeners();
    } else {
      if (onError != null) onError(null);
    }
  }
}
