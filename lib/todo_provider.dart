import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

class TodoProvider extends ChangeNotifier {
  TodoProvider({this.wsheet}) : _worksheet = wsheet;

  Worksheet? wsheet;
  final Worksheet? _worksheet;

  int numberOfTodos = 0;
  List<List<dynamic>> currentTodos = [];
  bool loading = true;

  TextEditingController inputController = TextEditingController();

  Future init() async {
    if (_worksheet == null) {
      print('worksheet is null!');
    }
    await countRows();
  }

  // bool checkLoading() {
  //   return loading;
  // }

  bool get checkLoading => loading;

  // void printCheck() {
  //   print('printCheck');
  //   print(numberOfTodos);
  //   print(currentTodos);
  // }

  // bool inputIsEmpty() {
  //   return inputController.text == '';
  // }

  void clearInputController() {
    inputController.clear();
    notifyListeners();
  }

  // insert a new note
  Future insert() async {
    if (inputController.text != '') {
      String todo = inputController.text;
      if (_worksheet == null) return;
      numberOfTodos++;
      currentTodos.add([todo, 0]);
      inputController.clear();
      await _worksheet!.values.appendRow([todo, 0]);
      notifyListeners();
    }
  }

  // count the number of notes
  Future countRows() async {
    while (
        (await _worksheet!.values.value(column: 1, row: numberOfTodos + 1)) !=
            '') {
      numberOfTodos++;
    }

    //  now we know how many notes to load, now load them
    await loadNotes();
  }

  // load existing notes from the sheet
  Future loadNotes() async {
    if (_worksheet == null) return;

    for (int i = 0; i < numberOfTodos; i++) {
      final String newNote =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final int newComplete =
          int.parse(await _worksheet!.values.value(column: 2, row: i + 1));
      if (currentTodos.length < numberOfTodos) {
        currentTodos.add([newNote, newComplete]);
      }
    }
    loading = false;
    notifyListeners();
  }

  Future update(int index, bool? isTaskCompleted) async {
    if (isTaskCompleted != null) {
      currentTodos[index][1] = isTaskCompleted ? 1 : 0;
      _worksheet!.values
          .insertValue(currentTodos[index][1], column: 2, row: index + 1);
      notifyListeners();
    }
  }

  Future deleteTodo(int index) async {
    currentTodos.removeAt(index);
    numberOfTodos = currentTodos.length;
    // worksheet
    await _worksheet!.deleteRow(index + 1); // row starts from 1

    notifyListeners();
  }
}
