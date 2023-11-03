import 'package:flutter/material.dart';
import 'package:hivetodo/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox(
      {super.key,
      required this.controller,
      required this.onCancel,
      required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //get user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1)),
                  border: OutlineInputBorder(),
                  hintText: "Add a new Task"),
            ),

            //buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //save button
                MyButton(text: "Save", onPressed: onSave),

                //Sized Box for creating a gap between these 2 buttons
                const SizedBox(
                  width: 8,
                ),
                //cancel button
                MyButton(text: "Cancel", onPressed: onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}
