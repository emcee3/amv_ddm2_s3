import 'package:amv_ddm2_s3/screens/task_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../task.dart';

class TaskListScreen extends StatefulWidget {
  TaskListScreen({Key key}) : super(key: key);

  @override
  _TaskListScreen createState() => _TaskListScreen();
}

class _TaskListScreen extends State<TaskListScreen> {
  List<Task> tasks = List<Task>();
  Task taskCreated;
  Box tasksBox;
  Color svgColor = Colors.orange;

  void changeColor(Color color) => setState(() => svgColor = color);

  @override
  void initState() {
    super.initState();
    tasksBox = Hive.box('tasks');
    if (tasksBox.isNotEmpty) {
      for (var i = 0; i < tasksBox.length; i++) {
        Task t = new Task(
            title: (tasksBox.getAt(i) as Task).title,
            isPressed: (tasksBox.getAt(i) as Task).isPressed
        );
        tasks.add(t);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: CupertinoColors.black,
          title: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0.0),
                      contentPadding: const EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      content: SingleChildScrollView(
                        child: SlidePicker(
                          pickerColor: svgColor,
                          onColorChanged: changeColor,
                          paletteType: PaletteType.rgb,
                          enableAlpha: false,
                          displayThumbColor: true,
                          showLabel: false,
                          showIndicator: true,
                          indicatorBorderRadius:
                          const BorderRadius.vertical(
                            top: const Radius.circular(25.0),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: SvgPicture.asset(
                'assets/img/check_circle.svg',
                color: svgColor,
                width: 48,
                height: 48,
              )
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
        body: ValueListenableBuilder(
          valueListenable: tasksBox.listenable(),
          builder: (context, Box box, _) {
            return tasks.length > 0
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
                  );
          },
        ));
  }

  addTask(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TaskScreen()));

    if (result != null) {
      setState(() {
        tasks.add(result);
        tasksBox.put((result as Task).title, result);
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
                    tasksBox.put(tasks[index].title, tasks[index]);
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
                    tasksBox.deleteAt(index);
                    print("Task Box:" + tasksBox.values.toString());
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
        });
  }
}
