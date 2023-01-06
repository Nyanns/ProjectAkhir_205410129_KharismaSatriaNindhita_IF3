import 'package:app/log_in/component/heading_text.dart';
import 'package:app/log_in/component/info.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 253, 253, 253),
            Color.fromRGBO(154, 217, 227, 1)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 54),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Logo(),
                  Credentials(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
