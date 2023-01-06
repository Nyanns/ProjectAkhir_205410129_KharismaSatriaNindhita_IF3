import 'package:flutter/material.dart';

class AccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;

  AccountCheck({
    required this.login,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? 'Belum Punya Akun? ' : 'Sudah punya akun?',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontFamily: 'Gluten-Regular',
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? 'Register' : ' Login',
            style: const TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 252, 81, 62),
              fontFamily: 'Gluten-Regular',
            ),
          ),
        ),
      ],
    );
  }
}
