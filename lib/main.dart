import 'dart:io';

import 'package:amv_ddm2_s3/screens/TaskListScreen.dart';
import 'package:amv_ddm2_s3/task.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocDirectory = await getApplicationDocumentsDirectory();

  new Directory(appDocDirectory.path+'/'+'dir').create(recursive: true)
      .then((Directory directory) {
    print('Path of New Dir: '+directory.path);
  });

  var path = appDocDirectory.path;
  Hive
    ..init(path)
    ..registerAdapter(TaskAdapter());

  await Hive.openBox('tasks');

  print(Hive.box('tasks').values);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TaskListScreen(),
    );
  }
}

