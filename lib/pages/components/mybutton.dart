import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  final VoidCallback? onTap;

  const Mybutton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        fixedSize: Size(175, 50),
      ),
      child: Text(
        'Submit',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}
