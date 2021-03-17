import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/base/module/todo.dart';
import 'package:todo_app/features/todo/action.dart';
import 'package:todo_app/features/todo/todo_bloc.dart';
import 'package:todo_app/widget/calender_row.dart';

Future<void> createNewTodoDialog(BuildContext context) {
  TextEditingController _textController = new TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();
  TodoBloc bloc = context.read<TodoBloc>();
  DateTime newDateTime;
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Create new Todo',
            style: TextStyle(
              color: Colors.blue,
              fontStyle: FontStyle.italic,
            ),
          ),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _textController,
                    minLines: 1,
                    maxLines: 5,
                    style: TextStyle(color: Colors.blue[700]),
                    validator: (String value) {
                      return value.isEmpty ? 'Please write some text!' : null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(gapPadding: 1.0),
                      labelText: 'Description',
                      labelStyle: TextStyle(
                        color: Colors.blue[700],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                CalendarRow(
                  (date) {
                    newDateTime = date;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  bloc.insertTodo(
                    DoInsertTodoAction(
                      Todo(
                        title: _textController.text,
                        done: false,
                        date: newDateTime,
                      ),
                    ),
                    onDone: (_) async {
                      Navigator.of(context).pop();
                    },
                  );
                }
              },
            ),
          ],
        );
      });
}

Future<void> updateTodoDialog(BuildContext context, Todo todo, VoidCallback onError) {
  TextEditingController _textController = TextEditingController(text: todo.title);
  final _formKey = GlobalKey<FormState>();
  TodoBloc bloc = context.read<TodoBloc>();
  DateTime newDateTime;
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Update Todo',
            style: TextStyle(
              color: Colors.blue,
              fontStyle: FontStyle.italic,
            ),
          ),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _textController,
                    minLines: 1,
                    maxLines: 5,
                    style: TextStyle(color: Colors.blue[700]),
                    cursorColor: Colors.blue[700],
                    validator: (String value) {
                      return value.isEmpty ? 'Please write some text!' : null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(gapPadding: 1.0),
                      labelText: 'Description',
                      labelStyle: TextStyle(
                        color: Colors.blue[700],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                CalendarRow(
                  (date) {
                    newDateTime = date;
                  },
                  date: todo.date,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  todo.title = _textController.text;
                  if (newDateTime != null) todo.date = newDateTime;
                  bloc.updateTodo(
                    DoUpdateTodoAction(todo),
                    onDone: (_) => Navigator.of(context).pop(),
                    onError: (_) => onError,
                  );
                }
              },
            ),
          ],
        );
      });
}
