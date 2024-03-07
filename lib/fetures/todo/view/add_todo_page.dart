import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/fetures/todo/view/todo_page.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/provider/todo_provider.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/utils/helper.dart';
import 'package:uuid/uuid.dart';

import '../../../widgets/app_text_field.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? dateTime;
  int priority = 1;
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
        title: const Text("Add Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(child: Consumer<TodoProvider>(
          builder: (context, provider, child) {
            return Column(
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
                  selectedPriority: priority,
                  onSelectedPriority: (priority) {
                    setState(() {
                      this.priority = priority;
                    });
                  },
                ),
                PickDateTimeButton(
                  dateTime: dateTime,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2200),
                      initialDate: DateTime.now(),
                    ).then((value) {
                      dateTime = value;
                      setState(() {});
                    });
                  },
                ),
                PickDateTimeButton(
                  dateTime: dateTime,
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((value) {
                      int h = value!.hour;
                      int m = value.minute;
                      dateTime = DateTime(
                          dateTime!.year, dateTime!.month, dateTime!.day, h, m);
                      setState(() {});
                    });
                  },
                  isPickDate: false,
                ),
                SizedBox(height: height * 0.04),
                AppCustomButton(
                  title: "Create task",
                  onTap: () {
                    TodoModel todo = TodoModel(
                      createdAt: DateTime.now(),
                      title: _titleController.text.trim(),
                      description: _descriptionController.text.trim(),
                      date: dateTime,
                      priority: priority,
                      id: const Uuid().v4(),
                    );

                    provider.addTodo(todo);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        )),
      ),
    );
  }
}

class AppCustomButton extends StatelessWidget {
  const AppCustomButton({super.key, required this.onTap, required this.title});

  final VoidCallback onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: height * 0.014),
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: buttonGradient,
        ),
        child: Align(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class PickDateTimeButton extends StatelessWidget {
  PickDateTimeButton({
    super.key,
    this.isPickDate = true,
    required this.onTap,
    this.dateTime,
  });
  DateTime? dateTime;
  bool isPickDate;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isPickDate
                ? Helper.getFormattedDate(dateTime)
                : Helper.getFormattedTime(dateTime),
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
          TextButton(
            onPressed: onTap,
            child: Text(isPickDate ? "Pick date" : "Pick time"),
          ),
        ],
      ),
    );
  }
}

class PriorityCheckBoxList extends StatelessWidget {
  PriorityCheckBoxList(
      {super.key,
      required this.onSelectedPriority,
      required this.selectedPriority});
  int selectedPriority;
  Function(int) onSelectedPriority;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PriorityCheckBox(
          color: highPriority,
          check: selectedPriority == 1,
          onSelectPriority: (priority) {
            onSelectedPriority(priority);
          },
          priority: 1,
        ),
        PriorityCheckBox(
          color: midPriority,
          check: selectedPriority == 2,
          onSelectPriority: (priority) {
            onSelectedPriority(priority);
          },
          priority: 2,
        ),
        PriorityCheckBox(
          color: lowPriority,
          check: selectedPriority == 3,
          onSelectPriority: (priority) {
            onSelectedPriority(priority);
          },
          priority: 3,
        ),
      ],
    );
  }
}

class PriorityCheckBox extends StatelessWidget {
  PriorityCheckBox(
      {super.key,
      required this.check,
      required this.color,
      required this.onSelectPriority,
      required this.priority});

  int priority;
  bool check;
  Function(int) onSelectPriority;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          shape: const CircleBorder(),
          value: check,
          activeColor: color,
          onChanged: (value) {
            onSelectPriority(priority);
          },
        ),
        Text(Helper.getPriorityString(priority))
      ],
    );
  }
}
