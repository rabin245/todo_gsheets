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
        itemCount: todoProvider.currentTodosLength,
        itemBuilder: (context, index) {
          return Slidable(
            endActionPane: buildActionPane(todoProvider, index, false),
            startActionPane: buildActionPane(todoProvider, index, true),
            child: MyTextBox(
              title: todoProvider.getCurrentTodoTitle(index),
              isChecked: todoProvider.getCurrentTodoIsCompleted(index),
              onTap: (newValue) {
                todoProvider.update(index, newValue);
              },
            ),
          );
        },
      ),
    );
  }

  ActionPane buildActionPane(
      TodoProvider todoProvider, int index, bool reversed) {
    List<SlidableAction> actions = [
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
    ];
    return ActionPane(
      motion: const StretchMotion(),
      children: reversed ? actions.reversed.toList() : actions,
    );
  }

  void showEditPopUp(context, index, todoProvider) {
    TextEditingController textController = TextEditingController();
    textController.text = todoProvider.getCurrentTodoTitle(index);
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        contentPadding: const EdgeInsets.all(10),
        title: const Text('Edit Todo'),
        children: [
          TextField(
            autofocus: true,
            controller: textController,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  todoProvider.editTodo(index, textController.text);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Edit',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
