import 'package:flutter/material.dart';
import 'package:hivetodo/util/dialog_box.dart';
import 'package:hivetodo/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  //text input controller -> for accessing the text value in TextField widget
  final _controller = TextEditingController();
  //list of todo tasks
  List toDoList = [
    ["Make Tutorial", false],
    ["Do exercise", false],
  ];

  //check-box was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  //save new task
  void saveNewTask() {
    setState(() {
      toDoList.add([_controller.text, false]);
      //clear up the textField content after saving
      _controller.clear();
    });

    //We use Navigator.of(context).pop() to terminate the dialog box
    Navigator.of(context).pop();
  }

  //create a new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  //delete a task
  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          centerTitle: true,
          title: Text('TO DO LIST'),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: createNewTask, child: Icon(Icons.add)),
        body: ListView.builder(
            itemCount: toDoList.length,
            itemBuilder: (context, index) {
              return ToDoTile(
                taskCompleted: toDoList[index][1],
                taskName: toDoList[index][0],
                onChanged: (value) => checkBoxChanged(value, index),
                deleteFunction: (context) => deleteTask(index),
              );
            }));
  }
}
