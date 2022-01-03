import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

class TodoProvider extends ChangeNotifier {
  TodoProvider(this._worksheet);

  final Worksheet? _worksheet;

  int _numberOfTodos = 0;
  final List<List<dynamic>> _currentTodos = [];
  bool _loading = true;

  Future init() async {
    if (_worksheet == null) {
      print('worksheet is null!');
      return;
    }
    countRows();
  }

  int get currentTodosLength => _currentTodos.length;

  String getCurrentTodoTitle(index) => _currentTodos[index][0];

  bool getCurrentTodoIsCompleted(index) =>
      _currentTodos[index][1] == 0 ? false : true;

  bool get checkLoading => _loading;

  // insert a new note
  Future insert(String todo) async {
    if (_worksheet == null) return;
    _numberOfTodos++;
    _currentTodos.add([todo, 0]);
    await _worksheet!.values.appendRow([todo, 0]);
    notifyListeners();
  }

  // count the number of notes
  Future countRows() async {
    while (
        (await _worksheet!.values.value(column: 1, row: _numberOfTodos + 1)) !=
            '') {
      _numberOfTodos++;
    }

    //  now we know how many notes to load, now load them
    await loadNotes();
  }

  // load existing notes from the sheet
  Future loadNotes() async {
    if (_worksheet == null) return;

    for (int i = 0; i < _numberOfTodos; i++) {
      final String newNote =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final int newComplete =
          int.parse(await _worksheet!.values.value(column: 2, row: i + 1));
      if (_currentTodos.length < _numberOfTodos) {
        _currentTodos.add([newNote, newComplete]);
      }
    }
    _loading = false;
    notifyListeners();
  }

  Future update(int index, bool? isTaskCompleted) async {
    if (isTaskCompleted != null) {
      _currentTodos[index][1] = isTaskCompleted ? 1 : 0;
      _worksheet!.values
          .insertValue(_currentTodos[index][1], column: 2, row: index + 1);
      notifyListeners();
    }
  }

  Future deleteTodo(int index) async {
    _currentTodos.removeAt(index);
    _numberOfTodos = _currentTodos.length;
    // worksheet
    await _worksheet!.deleteRow(index + 1); // row starts from 1

    notifyListeners();
  }

  Future editTodo(int index, String text) async {
    _currentTodos[index][0] = text;
    await _worksheet!.values.insertRow(index + 1, _currentTodos[index]);
    notifyListeners();
  }
}
