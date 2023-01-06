import 'package:app/account_check/account_check.dart';
import 'package:app/forget_password/forget_password.dart';
import 'package:app/home_screen/home_screen.dart';
import 'package:app/sign_up/sign_up_screen.dart';
import 'package:app/widget/bottom_square.dart';
import 'package:app/widget/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Credentials extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailTextControler =
      TextEditingController(text: '');
  final TextEditingController _passTextControler =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        const SizedBox(height: 18),
        const Center(
          child: Text(
            'Miku',
            style: TextStyle(
              fontSize: 56,
              color: Colors.black,
              fontFamily: 'Gluten-Regular',
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Center(
          child: Text(
            'Share Karyamu sekarang!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontFamily: 'Gluten-Regular',
            ),
          ),
        ),
        const SizedBox(height: 30),
        const Divider(
          color: Colors.black,
          thickness: 3,
        ),
        const SizedBox(height: 35),
        InputField(
          obscureText: false,
          textEditingController: _emailTextControler,
        ),
        InputField2(
          obscureText: true,
          textEditingController: _passTextControler,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ForgetPasswordScreen(),
                  ),
                );
              },
              child: const Text(
                'Lupa Password?',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontFamily: 'Gluten-Regular',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ButtonSquare(
          text: 'Login',
          press: () async {
            try {
              await _auth.signInWithEmailAndPassword(
                email: _emailTextControler.text.trim().toLowerCase(),
                password: _passTextControler.text.trim(),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => HomeScreen(),
                ),
              );
            } catch (error) {
              Fluttertoast.showToast(
                msg: error.toString(),
              );
            }
          },
        ),
        const SizedBox(
          height: 16,
        ),
        AccountCheck(
          login: true,
          press: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => SignUpScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}
