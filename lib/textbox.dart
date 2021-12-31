import 'package:flutter/material.dart';
import 'todo_provider.dart';
import 'package:provider/provider.dart';

class MyTextBox extends StatelessWidget {
  // const MyTextBox({
  //   Key? key,
  //   required this.title,
  //   required this.isChecked,
  //   required this.onTap,
  // }) : super(key: key);
  //
  // final String title;
  // final bool isChecked;
  // final onTap;
  const MyTextBox({Key? key, required this.index}) : super(key: key);
  final index;

  @override
  Widget build(BuildContext context) {
    var todoProvider = context.watch<TodoProvider>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(4),
        child: CheckboxListTile(
          value: todoProvider.currentTodos[index][1] == 0 ? false : true,
          onChanged: (newValue) {
            todoProvider.update(index, newValue);
          },
          title: Text(todoProvider.currentTodos[index][0]),
        ),
      ),
    );
  }
}
