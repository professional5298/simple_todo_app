import 'package:todo_app/base/module/todo.dart';

abstract class TodoAction {}

class DoInsertTodoAction extends TodoAction {
  final Todo todo;

  DoInsertTodoAction(this.todo);

  Map<String, Object> toMap() {
    return todo.toMap();
  }
}

class DoUpdateTodoAction extends TodoAction {
  final Todo todo;

  DoUpdateTodoAction(this.todo);

  Map<String, Object> toMap() {
    return todo.toMap();
  }
}

class DoDeleteTodoAction extends TodoAction {
  final int todoId;

  DoDeleteTodoAction(this.todoId);

  Map<String, Object> toMap() {
    return {'id': todoId};
  }
}
