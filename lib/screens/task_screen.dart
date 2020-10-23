import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../task.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({Key key}) : super(key: key);

  @override
  _TaskScreen createState() => _TaskScreen();
}

class _TaskScreen extends State<TaskScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              child: Text(
                'Què vols recordar?',
                style: TextStyle(
                    fontSize: 25,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: CupertinoTextField(
                maxLength: 20,
                controller: _controller,
                placeholder: 'Escriu una tasca...',
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  CupertinoButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancelar')
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                  ),
                  Expanded(
                        child: CupertinoButton(
                          color: Colors.orange,
                          onPressed: () {
                            if (_controller.text.isEmpty) {
                              return;
                            }
                            Navigator.pop(context, new Task(title: _controller.text, isPressed: false));
                          },
                          child: Text('Crear tasca'),
                        )
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
