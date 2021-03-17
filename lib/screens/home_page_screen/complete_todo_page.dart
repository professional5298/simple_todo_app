import 'package:flutter/material.dart';
import 'package:todo_app/base/module/todo.dart';
import 'package:todo_app/widget/todo_item.dart';

class CompleteTodoPage extends StatelessWidget {
  final List<Todo> todo;

  CompleteTodoPage(this.todo);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: MediaQuery.of(context).padding.copyWith(left: 10.0, right: 10.0),
      itemBuilder: (context, index) {
        return TodoItem(
          key: Key(todo[index].id.toString()),
          todo: todo[index],
          activeColor: Colors.green,
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.white,
          height: 5.0,
        );
      },
      physics: BouncingScrollPhysics(),
      itemCount: todo.length,
      shrinkWrap: true,
    );
  }
}
