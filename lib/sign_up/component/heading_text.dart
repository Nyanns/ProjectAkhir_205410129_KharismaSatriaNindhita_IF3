import 'package:flutter/material.dart';

class HeadText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Center(
          child: Text(
            'Selamat Datang!',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontFamily: 'Gluten-Regular',
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Divider(
          color: Colors.black,
          thickness: 3,
        ),
      ],
    );
  }
}
