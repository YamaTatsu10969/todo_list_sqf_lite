import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _priority;
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();

  final DateFormat _dateFormatter = DateFormat('yyyy年 MM月 dd日');
  final _priorities = <String>['低', '中', '高'];

  @override
  void initState() {
    super.initState();
    _dateController.text = _dateFormatter.format(_date);
  }

  _handleDatePicker() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('$_title, $_date, $_priority');

      // TODO: Insert the task to our user's database

      // TODO: Update the task
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Add Task',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            decoration: InputDecoration(
                                labelText: 'Title',
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            validator: (input) => input.trim().isEmpty
                                ? 'Please enter a task title'
                                : null,
                            onSaved: (input) => _title = input,
                            initialValue: _title,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: TextFormField(
                            readOnly: true,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            onTap: _handleDatePicker,
                            controller: _dateController,
                            decoration: InputDecoration(
                                labelText: 'Date',
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            validator: (input) => input.trim().isEmpty
                                ? 'Please enter a task title'
                                : null,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: DropdownButtonFormField(
                            icon: Icon(Icons.arrow_drop_down_circle),
                            iconSize: 20,
                            decoration: InputDecoration(
                                labelText: 'Priority',
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            iconEnabledColor: Theme.of(context).primaryColor,
                            items: _priorities.map(
                              (e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                            validator: (input) =>
                                input == null ? 'Please enter priority' : null,
                            onChanged: (value) {
                              setState(() {
                                _priority = value;
                              });
                            },
                            value: _priority,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: FlatButton(
                            child: Text(
                              'Add',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: _submit,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
