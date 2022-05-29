import 'package:flutter/material.dart';
import './models/task.dart';
import './new_task.dart';
// import 'package:intl/intl.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({Key? key, required this.task, required this.checkTk})
      : super(key: key);
  final Task task;
  final Function checkTk;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        title: Text(
          widget.task.title,
        ),
        subtitle: Text(widget.task.description),
        onTap: () => {},
      ),
    );
  }
}
