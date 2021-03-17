import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/base/module/todo.dart';
import 'package:todo_app/features/todo/action.dart';

final String tableTodo = 'todo';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDone = 'done';
final String columnDate = 'date';

class TodoService {
  TodoService._();

  static final TodoService db = TodoService._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version) async {
        await db.execute('''
          create table $tableTodo (
  $columnId integer primary key autoincrement,
  $columnTitle text not null,
  $columnDone integer not null,
  $columnDate text)
        ''');
      },
      version: 1,
    );
  }

  Future<Todo> insert(DoInsertTodoAction action) async {
    final db = await database;
    Todo todo = action.todo;
    todo.id = await db.insert(tableTodo, action.toMap());
    return todo;
  }

  Future<List<Todo>> getTodo() async {
    final db = await database;
    List<Map> maps = await db
        .query(tableTodo, columns: [columnId, columnDone, columnTitle, columnDate]);
    if (maps.length > 0) {
      List<Todo> tempList = [];
      maps.forEach((element) {
        tempList.add(Todo.fromMap(element));
      });
      return tempList;
    }
    return null;
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(DoUpdateTodoAction action) async {
    final db = await database;
    return await db.update(tableTodo, action.toMap(),
        where: '$columnId = ?', whereArgs: [action.todo.id]);
  }

  Future close() async => db.close();
}
