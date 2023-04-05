import 'package:flutter/material.dart';

class Rodape extends StatelessWidget {
  const Rodape({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset('assets/images/logo_saopaulo.png'),
        SizedBox(height: 16),
      ],
    );
  }
}
