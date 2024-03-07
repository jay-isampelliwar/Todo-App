import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/fetures/todo/view/update_todo_page.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/provider/todo_provider.dart';

import '../../../widgets/app_text_field.dart';
import '../../../widgets/custom_priority_check_list.dart';
import '../../../widgets/todo_custom_tile.dart';
import 'add_todo_page.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      Provider.of<TodoProvider>(context, listen: false).loadTodo();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    Provider.of<TodoProvider>(context).close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widget = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Consumer<TodoProvider>(builder: (context, provider, child) {
      return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          controller: _searchController,
                          hintText: "Search",
                          onChanged: (value) {
                            provider.searchTodo(value);
                          },
                        ),
                      ),
                      Visibility(
                        visible: provider.matchedTodos.isNotEmpty,
                        child: IconButton(
                          onPressed: () {
                            _searchController.clear();
                            provider.clearSearch();
                          },
                          icon: const Icon(Icons.close),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          provider.showAllTodo();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: provider.isAll
                                  ? Colors.white
                                  : Colors.grey.shade600,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Align(
                            child: Text("All"),
                          ),
                        ),
                      ),
                      CustomPriorityChipList(
                        onSelectedPriority: (value) {
                          provider.showPriorityTodo(value);
                        },
                        selectedPriority: provider.priority,
                      ),
                      PopupMenuButton(
                        // offset: Offset(0, hei),
                        icon: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.sort,
                          ),
                        ),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                                onTap: () {
                                  provider.sort(true);
                                },
                                child: const Text("Newest")),
                            PopupMenuItem(
                                onTap: () {
                                  provider.sort(false);
                                },
                                child: const Text("Oldest")),
                            PopupMenuItem(
                                onTap: () {
                                  provider.sortByDueDate();
                                },
                                child: const Text("Due date")),
                          ];
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  Divider(
                    thickness: 1,
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                  ),
                  Text(
                    "TODO List",
                    style: TextStyle(
                      fontSize: widget * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Visibility(
                    visible: provider.todos.isNotEmpty,
                    replacement: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: height * 0.2),
                        child: const Text("No Todo found",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                    child: provider.matchedTodos.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: provider.matchedTodos.length,
                            itemBuilder: (BuildContext context, int index) {
                              TodoModel todo = provider.matchedTodos[index];
                              return TodoCustomListTile(
                                onCheckBoxChanged: (value) {
                                  provider.todoCompleted(todo);
                                },
                                todo: todo,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateTodoPage(
                                        todo: todo,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: provider.todos.length,
                            itemBuilder: (BuildContext context, int index) {
                              TodoModel todo = provider.todos[index];
                              return TodoCustomListTile(
                                onCheckBoxChanged: (value) {
                                  provider.todoCompleted(todo);
                                },
                                todo: todo,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateTodoPage(
                                        todo: todo,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTodoPage(),
                ),
              );
            },
            child: Icon(
              Icons.add_rounded,
              size: widget * 0.08,
            ),
          ),
        ),
      );
    });
  }
}
