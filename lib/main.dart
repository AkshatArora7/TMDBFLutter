import 'package:flutter/material.dart';
import 'package:untitled/screens/screen1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Command Space Tech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const screen1(),
    );
  }
}

