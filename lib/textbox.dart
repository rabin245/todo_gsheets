import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  const MyTextBox({
    Key? key,
    required this.title,
    required this.isChecked,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final bool isChecked;
  final dynamic onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(4),
        child: CheckboxListTile(
          activeColor: Colors.deepPurple,
          value: isChecked,
          onChanged: onTap,
          title: Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
