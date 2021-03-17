import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/base/module/todo.dart';
import 'package:todo_app/base/tool/alert.dart';
import 'package:todo_app/base/tool/time_parse.dart';
import 'package:todo_app/features/todo/action.dart';
import 'package:todo_app/features/todo/todo_bloc.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;

  final Key key;

  final Color activeColor;

  TodoItem({
    this.key,
    this.todo,
    this.activeColor,
  });

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableStrechActionPane(),
      actionExtentRatio: 0.2,
      child: Card(
        elevation: 4.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: CheckboxListTile(
          onChanged: (newValue) => context.read<TodoBloc>().updateTodo(
                DoUpdateTodoAction(
                  Todo(
                    id: widget.todo.id,
                    title: widget.todo.title,
                    done: !widget.todo.done,
                    date: widget.todo.date,
                  ),
                ),
              ),
          value: widget.todo.done,
          title: Text(
            widget.todo.title,
            style: TextStyle(
              color: widget.todo.done ? Colors.black : Colors.grey,
            ),
          ),
          activeColor: widget.activeColor ?? Colors.blue,
          subtitle: widget.todo.date == null
              ? null
              : Text(
                  formatDateTime(widget.todo.date),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.white,
          icon: Icons.edit,
          onTap: () => updateTodoDialog(context, widget.todo, () {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Opp! Something wrong happens'),
                duration: Duration(seconds: 2),
              ),
            );
          }),
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => context.read<TodoBloc>().deleteTodo(
                DoDeleteTodoAction(
                  widget.todo.id,
                ),
                onError: (_) => SnackBar(
                  content: Text('Opp! Something wrong happens'),
                  duration: Duration(seconds: 2),
                ),
              ),
        ),
      ],
    );
  }
}
