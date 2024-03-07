import 'dart:developer';

import 'package:flutter/material.dart';

import '../utils/helper.dart';

class CustomPriorityChipList extends StatelessWidget {
  CustomPriorityChipList({
    super.key,
    required this.onSelectedPriority,
    required this.selectedPriority,
  });

  int selectedPriority;
  Function(int) onSelectedPriority;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            onSelectedPriority(1);
          },
          child: CustomPriorityChip(
            selected: selectedPriority == 1,
            priority: 1,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            onSelectedPriority(2);
          },
          child: CustomPriorityChip(
            selected: selectedPriority == 2,
            priority: 2,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            onSelectedPriority(3);
          },
          child: CustomPriorityChip(
            selected: selectedPriority == 3,
            priority: 3,
          ),
        ),
      ],
    );
  }
}

class CustomPriorityChip extends StatelessWidget {
  CustomPriorityChip({
    super.key,
    required this.priority,
    required this.selected,
  });

  bool selected;
  final int priority;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: selected
              ? Helper.getPriorityColor(priority)
              : Colors.grey.shade600,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Align(
        child: Row(
          children: [
            Icon(
              Icons.circle,
              color: Helper.getPriorityColor(priority),
            ),
            const SizedBox(width: 4),
            Text(Helper.getPriorityString(priority).split(" ")[0]),
          ],
        ),
      ),
    );
  }
}
