import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/hive_database.dart';
import 'package:todo_app/utility/colors.dart';

import '../utility/box_dialog.dart';
import '../utility/todo_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();
  final _myBox = Hive.box("box");

  ToDoDataBase td = ToDoDataBase();
  //
  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      td.defultData();
    } else {
      td.loadData();
    }
    super.initState();
  }

  void checkBox(bool? value, int index) {
    setState(() {
      td.toDoList[index][1] = !td.toDoList[index][1];
    });
    td.updateData();
  }

  //save task
  void saveTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        td.toDoList.add([_controller.text, false]);
        _controller.clear();
      });
      Navigator.of(context).pop();
    }
    td.updateData();
  }

  //
  void showDialogCard() {
    showDialog(
      context: context,
      builder: (context) {
        return BoxDialog(
          controller: _controller,
          onSave: () {
            saveTask();
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
    td.updateData();
  }
  //delete task

  deleteTask(int index) {
    setState(() {
      td.toDoList.removeAt(index);
    });
    td.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: primaryColor,
        title: const Text(
          "TO DO",
          style: TextStyle(color: whiteText),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: (td.toDoList.isEmpty)
            ? const Center(
                child: Padding(
                padding: EdgeInsets.all(25),
                child: Text("Add New Task"),
              ))
            : ListView.builder(
                itemCount: td.toDoList.length,
                itemBuilder: (context, index) {
                  // ignore: unnecessary_null_comparison
                  return ToDoTile(
                    taskName: td.toDoList[index][0],
                    checkTask: td.toDoList[index][1],
                    onChanged: (value) => checkBox(value, index),
                    onDelete: (value) => deleteTask(index),
                  );
                },
              ),
      ),
      //
      floatingActionButton: FloatingActionButton(
        backgroundColor: yellowButton,
        child: const Icon(
          Icons.add,
          color: darkText,
        ),
        onPressed: () {
          showDialogCard();
          td.updateData();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
