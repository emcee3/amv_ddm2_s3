import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key key}) : super(key: key);

  @override
  _TaskScreen createState() => _TaskScreen();
}

class _TaskScreen extends State<TaskScreen> {
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
                style: TextStyle(fontSize: 25),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Escriu una tasca...', border: InputBorder.none),
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
                  FlatButton(onPressed: null, child: Text('Cancelar')),
                  Expanded(
                        child: OutlineButton(
                          onPressed: null,
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
