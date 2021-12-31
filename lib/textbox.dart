import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  const MyTextBox({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.grey[700], fontSize: 12),
          ),
        ),
      ),
    );
  }
}
