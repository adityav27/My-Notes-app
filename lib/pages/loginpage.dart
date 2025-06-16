import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    var container = Container(
      width: 500,
      //background color
      decoration: backgroundColor(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
    return Scaffold(body: container);
  }
}

BoxDecoration backgroundColor() {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromARGB(255, 255, 255, 255),
        Color.fromARGB(255, 113, 61, 156),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );
}
