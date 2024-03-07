import 'package:flutter/material.dart';

import '../model/todo_model.dart';
import '../utils/helper.dart';

class TodoCustomListTile extends StatelessWidget {
  TodoCustomListTile({
    super.key,
    required this.todo,
    required this.onTap,
    required this.onCheckBoxChanged,
  });
  VoidCallback onTap;
  TodoModel todo;
  Function(bool) onCheckBoxChanged;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.11,
        margin: const EdgeInsets.only(bottom: 8),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(16),
        ),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  height: constraints.maxHeight,
                  decoration: BoxDecoration(
                    color: Helper.getPriorityColor(todo.priority),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 12,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              todo.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                decoration: todo.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              todo.description,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            SizedBox(height: constraints.maxHeight * 0.08),
                            todo.date != null
                                ? Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_rounded,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "${Helper.getFormattedTime(todo.date!)} ${Helper.getFormattedDate(todo.date!)}",
                                        style: const TextStyle(),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink()
                          ],
                        ),
                      ),
                      Checkbox(
                        shape: const CircleBorder(),
                        value: todo.isCompleted,
                        onChanged: (value) {
                          onCheckBoxChanged(value!);
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
