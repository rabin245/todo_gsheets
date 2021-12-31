import 'package:flutter/material.dart';
import 'textbox.dart';
import 'todo_provider.dart';
import 'package:provider/provider.dart';

class MyTodoList extends StatelessWidget {
  const MyTodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todoProvider = context.watch<TodoProvider>();
    return Expanded(
      child: ListView.builder(
        itemCount: todoProvider.currentTodos.length,
        itemBuilder: (context, index) {
          // return MyTextBox(
          //   title: todoProvider.currentTodos[index][0],
          //   isChecked: todoProvider.currentTodos[index][1] == 0 ? false : true,
          //   onTap: (newValue) {
          //     todoProvider.update(index, newValue == false ? 0 : 1);
          //   },
          // );
          return MyTextBox(index: index);
        },
      ),
    );
  }
}
