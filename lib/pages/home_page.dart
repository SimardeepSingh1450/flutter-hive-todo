import 'package:flutter/material.dart';
import 'package:hivetodo/data/database.dart';
import 'package:hivetodo/util/dialog_box.dart';
import 'package:hivetodo/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  //reference the hive box
  final _myBox = Hive.box('myBox');
  ToDoDataBase db = ToDoDataBase();

  //nit state synatx using flutter-intellisense:
  @override
  void initState() {
    // TODO: implement initState

    //if this is the first time ever opening the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //there already exists data
      db.loadData();
    }

    super.initState();
  }

  //text input controller -> for accessing the text value in TextField widget
  final _controller = TextEditingController();

  //list of todo tasks
  // List toDoList = [
  //   ["Make Tutorial", false],
  //   ["Do exercise", false],
  // ];

  //check-box was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });

    //make db update changes inside hive using updateDatabase
    db.updateDataBase();
  }

  //save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      //clear up the textField content after saving
      _controller.clear();
    });

    //We use Navigator.of(context).pop() to terminate the dialog box
    Navigator.of(context).pop();

    //make db update changes inside hive using updateDatabase
    db.updateDataBase();
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
      db.toDoList.removeAt(index);
    });

    //make db update changes inside hive using updateDatabase
    db.updateDataBase();
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
            itemCount: db.toDoList.length,
            itemBuilder: (context, index) {
              return ToDoTile(
                taskCompleted: db.toDoList[index][1],
                taskName: db.toDoList[index][0],
                onChanged: (value) => checkBoxChanged(value, index),
                deleteFunction: (context) => deleteTask(index),
              );
            }));
  }
}
