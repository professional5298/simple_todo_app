import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/base/tool/alert.dart';
import 'package:todo_app/features/todo/todo_bloc.dart';
import 'package:todo_app/screens/home_page_screen/all_todo_page.dart';
import 'package:todo_app/screens/home_page_screen/complete_todo_page.dart';
import 'package:todo_app/screens/home_page_screen/incomplete_todo_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController = new PageController(initialPage: 0);

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO List'),
        backgroundColor: buttonColor(_currentIndex),
      ),
      body: Consumer<TodoBloc>(
        builder: (context, bloc, child) {
          return PageView(
            children: <Widget>[
              AllTodoPage(bloc.listTodo),
              CompleteTodoPage(bloc.completeTodo),
              IncompleteTodoPage(bloc.incompleteTodo),
            ],
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.notes),
            label: 'ALL',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            icon: Icon(Icons.done),
            label: 'Complete',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.red,
            icon: Icon(Icons.cancel),
            label: 'Incomplete',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(_currentIndex);
          });
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        elevation: 0.0,
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () {
            createNewTodoDialog(context);
          },
          elevation: 0.0,
          child: Icon(
            Icons.add,
          ),
          backgroundColor: buttonColor(_currentIndex),
        ),
      ),
    );
  }
}

Color buttonColor(int index) {
  switch (index) {
    case 0:
      return Colors.blue;
      break;
    case 1:
      return Colors.green;
      break;
    case 2:
      return Colors.red;
      break;
    default:
      return Colors.blue;
      break;
  }
}
