import 'package:flutter/material.dart';
import 'pages/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Busca de Livros',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: homeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
