import 'package:flutter/material.dart';

class CardTitleWidget extends StatelessWidget {
  final String title;
  const CardTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
