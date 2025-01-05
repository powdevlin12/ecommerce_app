import 'package:ercomerce_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(
          content: "Home",
        ),
      ),
      body: SafeArea(
          child: Container(
        child: const Text('This is home screen'),
      )),
    );
  }
}
