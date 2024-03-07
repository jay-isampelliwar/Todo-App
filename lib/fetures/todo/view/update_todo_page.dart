import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/fetures/todo/view/todo_page.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/provider/todo_provider.dart';

import '../../../widgets/app_text_field.dart';
import 'add_todo_page.dart';

class UpdateTodoPage extends StatefulWidget {
  UpdateTodoPage({required this.todo, super.key});
  TodoModel todo;
  @override
  State<UpdateTodoPage> createState() => _UpdateTodoPageState();
}

class _UpdateTodoPageState extends State<UpdateTodoPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? dateTime;
  @override
  void initState() {
    super.initState();

    _titleController.text = widget.todo.title;
    _descriptionController.text = widget.todo.description;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Todo"),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<TodoProvider>(context, listen: false)
                  .deleteTodo(widget.todo);

              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppTextField(
                controller: _titleController,
                showLabel: true,
                hintText: "Title",
                onChanged: (value) {},
              ),
              SizedBox(height: height * 0.02),
              AppTextField(
                controller: _descriptionController,
                showLabel: true,
                hintText: "Description (optional)",
                onChanged: (value) {},
              ),
              SizedBox(height: height * 0.01),
              PriorityCheckBoxList(
                selectedPriority: widget.todo.priority,
                onSelectedPriority: (priority) {
                  setState(() {
                    widget.todo.priority = priority;
                  });
                },
              ),
              PickDateTimeButton(
                dateTime: widget.todo.date,
                onTap: () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2200),
                    initialDate: DateTime.now(),
                  ).then((value) {
                    widget.todo.date = value;
                    setState(() {});
                  });
                },
              ),
              PickDateTimeButton(
                dateTime: widget.todo.date,
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {
                    int h = value!.hour;
                    int m = value.minute;
                    widget.todo.date = DateTime(widget.todo.date!.year,
                        widget.todo.date!.month, widget.todo.date!.day, h, m);
                    setState(() {});
                  });
                },
                isPickDate: false,
              ),
              SizedBox(height: height * 0.04),
              AppCustomButton(
                title: "Update task",
                onTap: () {
                  widget.todo.title = _titleController.text.trim();
                  widget.todo.description = _descriptionController.text.trim();

                  Provider.of<TodoProvider>(context, listen: false)
                      .updateTodo(widget.todo);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
