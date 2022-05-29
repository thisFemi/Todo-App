import 'package:flutter/material.dart';
import 'package:mytodo/models/task.dart';
import 'package:mytodo/new_task.dart';
import './task_list.dart';
import './task_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyT-Do App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Task> _userTasks = [];
  List<Task> get _recentTransactions {
    return _userTasks.where((tk) {
      return tk.date.isAfter(DateTime.now().subtract(
        Duration(days: 15),
      ));
    }).toList();
  }

  void _addNewTask(String tktitle, String description, DateTime chosenDate) {
    final newTk = Task(
        id: DateTime.now().toString(),
        title: tktitle,
        description: description,
        date: chosenDate);

    setState(() {
      _userTasks.add(newTk);
    });
  }

  void _startAddNewTask(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTask(_addNewTask),
          behavior: HitTestBehavior.translucent,
        );
      },
    );
  }

  void _checkTask(String id) {
    setState(() {
      _userTasks.removeWhere((tk) => tk.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final tkListWidget = Container( height: (MediaQuery.of(context).size.height -
    //           appBar.preferredSize.height -
    //           mediaQuery.padding.top) *
    //       0.7,
    //   child: TaskList(_userTasks, _checkTask));
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.alarm,
          color: Colors.green,
        ),
        centerTitle: true,
        title: const Text(
          'MyTdo App',
          style: TextStyle(
            color: Colors.green,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => _startAddNewTask(context),
            icon: const Icon(Icons.add_alert_rounded),
            color: Colors.green,
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TaskList(_userTasks, _checkTask),
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_circle,
          color: Colors.black,
        ),
        onPressed: () => _startAddNewTask(context),
      ),
    );
  }
}
