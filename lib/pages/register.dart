import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    var container = Container(
      width: 500,
      //background color
      decoration: backgroundColor(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Sign Up',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ],
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
        Color.fromARGB(255, 130, 184, 255),
        Color.fromARGB(255, 113, 61, 156),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );
}
