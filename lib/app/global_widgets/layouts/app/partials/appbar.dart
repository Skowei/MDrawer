import 'package:flutter/material.dart';

AppBar myAppBar() {
  return AppBar(
    title: const Text("Title"),
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.more_vert),
        tooltip: 'Show To Do Lists',
        onPressed: () {},
      ),
    ],
  );
}
