import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
          return Slidable(
            // key: ValueKey(index),
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              // dismissible: DismissiblePane(onDismissed: () {}),
              children: [
                SlidableAction(
                  onPressed: (context) async {
                    await todoProvider.deleteTodo(index);
                  },
                  backgroundColor: Colors.red.shade700,
                  foregroundColor: Colors.white,
                  icon: Icons.delete_forever_rounded,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                    showEditPopUp(context, index, todoProvider);
                  },
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
              ],
            ),
            startActionPane: ActionPane(
              // dismissible: DismissiblePane(onDismissed: () {}),
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    showEditPopUp(context, index, todoProvider);
                  },
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
                SlidableAction(
                  onPressed: (context) async {
                    await todoProvider.deleteTodo(index);
                  },
                  backgroundColor: Colors.red.shade700,
                  foregroundColor: Colors.white,
                  icon: Icons.delete_forever_rounded,
                  label: 'Delete',
                ),
              ],
            ),
            child: MyTextBox(
              title: todoProvider.currentTodos[index][0],
              isChecked:
                  todoProvider.currentTodos[index][1] == 0 ? false : true,
              onTap: (newValue) {
                todoProvider.update(index, newValue);
              },
            ),
          );
        },
      ),
    );
  }

  void showEditPopUp(context, index, todoProvider) {
    TextEditingController textController = TextEditingController();
    textController.text = todoProvider.currentTodos[index][0];
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => SimpleDialog(
        contentPadding: EdgeInsets.all(10),
        title: Text('Edit Todo'),
        children: [
          TextField(
            decoration: InputDecoration(),
            autofocus: true,
            controller: textController,
          ),
          ElevatedButton(
            onPressed: () {
              todoProvider.editTodo(index, textController.text);
              Navigator.of(context).pop();
            },
            child: Text('Edit'),
          ),
        ],
      ),
    );
  }
}
