import 'package:flutter/material.dart';
import 'google_sheets_api.dart';
import 'textbox.dart';

class MyTodoList extends StatefulWidget {
  const MyTodoList({Key? key}) : super(key: key);

  @override
  _MyTodoListState createState() => _MyTodoListState();
}

class _MyTodoListState extends State<MyTodoList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: GoogleSheetsApi.currentNotes.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            value: GoogleSheetsApi.currentNotes[index][1] == 0 ? false : true,
            onChanged: (newValue) {
              GoogleSheetsApi.update(index, newValue == false ? 0 : 1);
              setState(() {
                GoogleSheetsApi.currentNotes[index][1] =
                    (newValue == false ? 0 : 1);
              });
            },
            title: Text(GoogleSheetsApi.currentNotes[index][0]),
          );
        },
      ),
    );
  }
}
