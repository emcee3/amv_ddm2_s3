import 'package:amv_ddm2_s3/models/Task.dart';
import 'package:amv_ddm2_s3/pages/TaskScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TaskListScreen extends StatefulWidget {
  TaskListScreen({Key key}) : super(key: key);

  @override
  _TaskListScreen createState() => _TaskListScreen();
}

class _TaskListScreen extends State<TaskListScreen> {
  List<Task> tasks = List<Task>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CupertinoColors.black,
        title: SvgPicture.asset(
          'assets/img/check_circle.svg',
          color: Colors.orange,
          width: 48,
          height: 48,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TaskScreen()));
            }
          ),
        ],
      ),
      backgroundColor: CupertinoColors.black,
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(
              tasks[index].title,
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            value: false,
          );
        },
      ),
    );
  }

  addTask(Task task){
    setState(() {
      tasks.add(task);
    });
  }
}
