import 'package:flutter/material.dart';

class HeadText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Center(
          child: Text(
            'LUPA PASSWORD',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontFamily: 'Gluten-Regular',
            ),
          ),
        ),
        SizedBox(
          height: 21,
        ),
        Divider(
          color: Colors.black,
          thickness: 3,
        ),
      ],
    );
  }
}
