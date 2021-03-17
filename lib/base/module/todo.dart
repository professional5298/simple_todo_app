final String columnId = 'id';
final String columnTitle = 'title';
final String columnDone = 'done';
final String columnDate = 'date';

class Todo {
  int id;
  String title;
  bool done;
  DateTime date;

  Todo({this.id, this.title, this.done, this.date});

  Map<String, Object> toMap() {
    var map = <String, Object>{
      columnTitle: title,
      columnDone: done == true ? 1 : 0,
    };
    if (id != null) {
      map[columnId] = id;
    }
    if (date != null) {
      map[columnDate] = date.toIso8601String();
    }
    return map;
  }

  Todo.fromMap(Map<String, Object> map) {
    id = map[columnId];
    title = map[columnTitle];
    done = map[columnDone] == 1;
    if (map[columnDate] != null) date = DateTime.parse(map[columnDate]);
  }
}
