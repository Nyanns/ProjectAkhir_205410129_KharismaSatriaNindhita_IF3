import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage('images/mikikimikik.png'),
            backgroundColor: Color.fromRGBO(255, 255, 255, 0),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            'Miku',
            style: TextStyle(
              fontSize: 40,
              color: Colors.black,
              fontFamily: 'Gluten-Regular',
            ),
          )
        ],
      ),
    );
  }
}
