import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:todo_app/base/tool/time_parse.dart';

class CalendarRow extends StatefulWidget {
  final ValueChanged<DateTime> onChange;

  final DateTime date;

  CalendarRow(this.onChange, {this.date});

  _CalendarRowState createState() => _CalendarRowState();
}

class _CalendarRowState extends State<CalendarRow> {
  DateTime newDateTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newDateTime = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            Icons.calendar_today,
            color: Colors.blue,
          ),
          onPressed: () async {
            newDateTime = await showRoundedDatePicker(
              context: context,
              theme: ThemeData(primarySwatch: Colors.blue),
              initialDate: newDateTime ?? DateTime.now(),
              lastDate: DateTime(DateTime.now().year + 5),
              borderRadius: 16,
              imageHeader: AssetImage('assets/images/calendar_header.jpg'),
              description:
                  'There is no such thing as a coincidence in this world. There is only the inevitable',
            );
            if (newDateTime != null) {
              setState(() {
                widget.onChange(newDateTime);
              });
            }
          },
        ),
        Text(
          newDateTime == null ? 'Pick a time' : formatDateTime(newDateTime),
          style: TextStyle(
            color: Colors.blue[700],
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
