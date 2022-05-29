import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class NewTask extends StatefulWidget {
  // const NewTask({ Key? key }) : super(key: key);
  final Function addTk;
  NewTask(this.addTk);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredDescripton = descriptionController.text;

    if (enteredTitle.isEmpty || _selectedDate == DateTime.parse('0000-00-00')) {
      return;
    }
    widget.addTk(
      enteredTitle,
      enteredDescripton,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime(2023))
        .then((pickDate) {
      if (pickDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.only(
            top: 30,
            left: 10,
            right: 10,
            bottom: 200,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Task Title"),
                controller: titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                autocorrect: true,
                decoration: InputDecoration(labelText: 'Description'),
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                minLines: 2,
                maxLines: 5,
                onSubmitted: (_) => _submitData,
              ),
              Container(
                height: 70,
                child: Row(children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == DateTime.parse('0000-00-00')
                        ? 'No Date Chosen'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                  ),
                  FlatButton(
                      textColor: Colors.green,
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ]),
              ),
              RaisedButton(
                onPressed: _submitData,
                child: Text('Add Task'),
                color: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }
}
