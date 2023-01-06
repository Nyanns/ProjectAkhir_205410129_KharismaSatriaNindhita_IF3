import 'package:flutter/material.dart';

class Images extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          'images/Component7.png',
          height: 300,
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
