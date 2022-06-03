import 'package:mdrawer/app.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mdrawer/app/modules/project/model/project.dart';
import 'package:mdrawer/app/modules/task/model/task.dart';

void main() async {
  await _init();
  runApp(
    const MyApp(),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter("MDrawer/Hive");

  await Hive.openBox('theme');

  Hive.registerAdapter<Project>(ProjectAdapter());
  await Hive.openBox<Project>('projects');

  Hive.registerAdapter<Task>(TaskAdapter());
}
