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
  Task taskCreated;

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
                addTask(context);
              }),
        ],
      ),
      backgroundColor: CupertinoColors.black,
      body: tasks.length > 0
          ? ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: CheckboxListTile(
                    title: Text(
                      tasks[index].title,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    value: tasks[index].isPressed,
                    onChanged: (bool value) {
                      setState(() {
                        clickTask(index, value);
                      });
                    },
                    activeColor: Colors.white,
                    checkColor: Colors.black,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                );
              },
            )
          : Center(
              child: Container(
                child: Text(
                  'no items',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
    );
  }

  addTask(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TaskScreen()));

    if (result != null) {
      setState(() {
        tasks.add(result);
      });
    }
  }

  Future<void> clickTask(int index, bool value) async {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: Text('Opcions'),
            actions: [
              CupertinoActionSheetAction(
                child: (tasks[index].isPressed)
                    ? Text('Desmarca la tasca')
                    : Text('Marca la tasca'),
                isDefaultAction: true,
                onPressed: () {
                  setState(() {
                    tasks[index].isPressed = value;
                  });
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: Text('Elimina la tasca'),
                isDestructiveAction: true,
                onPressed: () {
                  setState(() {
                    tasks.removeAt(index);
                  });
                  Navigator.pop(context);
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          );
        }
    );
  }
}
