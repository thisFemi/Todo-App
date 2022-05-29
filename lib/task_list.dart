import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './models/task.dart';
import './task_item.dart';

class TaskList extends StatelessWidget {
  // const TaskList({Key? key}) : super(key: key);
  final List<Task> tasks;
  final Function checkTk;
  TaskList(this.tasks, this.checkTk);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      child: tasks.isEmpty
          ? Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Text(
                  'No Task Yet',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            DateFormat.Md().format(tasks[index].date),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    title: Text(tasks[index].title),
                    subtitle: Text(tasks[index].description),
                    trailing: IconButton(
                      icon: Icon(Icons.check_circle),
                      color: Colors.red,
                      onPressed: () => checkTk(tasks[index].id),
                    ),
                    onTap: () => print("hi"),
                  ),
                );
              },
              itemCount: tasks.length,
            ),
    );
  }
}
