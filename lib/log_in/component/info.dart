import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Center(
            child: CircleAvatar(
              radius: 74,
              backgroundImage: AssetImage('images/mikikimikik.png'),
              backgroundColor: Color.fromRGBO(255, 255, 255, 0),
            ),
          )
        ],
      ),
    );
  }
}
