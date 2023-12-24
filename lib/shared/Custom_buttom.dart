import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  Widget title;
  Color color;
  Function onPressed;
  CustomButtom(
      {super.key,
      required this.title,
      required this.color,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(backgroundColor: color, elevation: 8),
      child: title,
    );
  }
}
