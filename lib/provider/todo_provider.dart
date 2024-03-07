import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/todo_model.dart';
import '../services/store_services.dart';

class TodoProvider with ChangeNotifier {
  int _priority = -1;
  bool isAll = false;
  List<TodoModel> todos = [];
  List<TodoModel> matchedTodos = [];
  int get priority => _priority;

  void setAll(bool value) {
    isAll = value;
    notifyListeners();
  }

  Future<void> loadTodo() async {
    todos = await Store.getTodos();
    notifyListeners();
  }

  Future<void> addTodo(TodoModel todoModel) async {
    todos.add(todoModel);
    await Store.addTodo(todoModel);
    notifyListeners();
  }

  Future<void> deleteTodo(TodoModel model) async {
    todos.remove(model);
    await Store.deleteTodo(model);
    notifyListeners();
  }

  Future<void> updateTodo(TodoModel todoModel) async {
    todos[todos.indexOf(todoModel)] = todoModel;

    await Store.updateTodo(todoModel);
    notifyListeners();
  }

  void todoCompleted(TodoModel model) {
    todos[todos.indexOf(model)].isCompleted = !model.isCompleted;

    updateTodo(model);
  }

  void searchTodo(String query) {
    if (query.isEmpty) {
      matchedTodos.clear();
      notifyListeners();
      return;
    }

    List<TodoModel> filteredTodos = [];
    matchedTodos.clear();

    for (TodoModel todo in todos) {
      if (todo.title.toLowerCase().contains(query.toLowerCase())) {
        filteredTodos.add(todo);
      }
    }

    matchedTodos = filteredTodos;
    notifyListeners();
  }

  void showHighPriorityTodo() {
    matchedTodos = todos.where((element) => element.priority == 1).toList();
    notifyListeners();
  }

  void showLowPriorityTodo() {
    matchedTodos = todos.where((element) => element.priority == 3).toList();
    notifyListeners();
  }

  void showMidPriorityTodo() {
    matchedTodos = todos.where((element) => element.priority == 2).toList();
    notifyListeners();
  }

  void showAllTodo() {
    _priority = 0;
    setAll(true);
    matchedTodos.clear();
    notifyListeners();
  }

  void close() {
    Store().close();
  }

  void sort(bool value) {
    // if value is true sort by newest first
    // else sort by oldest first

    if (value) {
      todos.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else {
      todos.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }

    notifyListeners();
  }

  void sortByDueDate() {
    todos.sort((a, b) => a.date!.compareTo(b.date!));
    notifyListeners();
  }

  void showPriorityTodo(int value) {
    setAll(false);
    _priority = value;

    if (value == 1) showHighPriorityTodo();
    if (value == 2) showMidPriorityTodo();
    if (value == 3) showLowPriorityTodo();
  }

  void clearSearch() {
    matchedTodos.clear();
    notifyListeners();
  }
}
