import 'package:flutter/material.dart';
import 'package:photo_viewer/screens/home_page.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'permission_handler | flutter',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomePage(),
    );
  }
}
