import 'dart:developer';

import 'package:hive/hive.dart';

import '../model/todo_model.dart';

class Store {
  static var todoBox = Hive.box<TodoModel>('todoBox');

  static Future<void> addTodo(TodoModel todoModel) async {
    await todoBox.put(todoModel.id, todoModel);
    int len = todoBox.length;
    printLen();
  }

  static Future<List<TodoModel>> getTodos() async {
    List<TodoModel> list = todoBox.values.toList();
    printLen();
    return todoBox.values.toList();
  }

  static Future<void> deleteTodo(TodoModel todo) async {
    await todoBox.delete(todo.id);
    printLen();
  }

  static Future<void> updateTodo(TodoModel todoModel) async {
    await todoBox.put(todoModel.id, todoModel);
  }

  static Future<void> printLen() async {
    int len = todoBox.length;
    log("===================");
    log(len.toString());
    log("===================");
  }

  void close() {
    todoBox.close();
  }
}
