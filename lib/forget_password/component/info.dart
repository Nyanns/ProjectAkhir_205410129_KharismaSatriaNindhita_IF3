import 'package:app/account_check/account_check.dart';
import 'package:app/log_in/login_screen.dart';
import 'package:app/widget/bottom_square.dart';
import 'package:app/widget/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Credentials extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailTextController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              'RESET SEKARANG?',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: 'Gluten-Regular',
              ),
            )
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        InputField3(
          hintText: 'Masukkan Emailmu!',
          icon: Icons.email,
          obscureText: false,
          textEditingController: _emailTextController,
        ),
        const SizedBox(
          height: 12,
        ),
        ButtonSquare(
          text: 'Kirim Link',
          press: () async {
            try {
              await _auth.sendPasswordResetEmail(
                  email: _emailTextController.text);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Color.fromRGBO(154, 217, 227, 1),
                  content: Text(
                    " - Buka Emailmu dari Mikumiku!!!",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 97, 97, 97),
                      fontFamily: 'Gluten-Regular',
                    ),
                  ),
                ),
              );
            } on FirebaseAuthException catch (error) {
              Fluttertoast.showToast(msg: error.toString());
            }
          },
        ),
        const SizedBox(
          height: 14,
        ),
        AccountCheck(
          login: false,
          press: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => LoginScreen(),
              ),
            );
          },
        )
      ],
    );
  }
}
