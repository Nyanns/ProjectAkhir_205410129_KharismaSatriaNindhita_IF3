import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  TextFieldContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Email',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: 'Gluten-Regular',
                ),
                textAlign: TextAlign.left),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                width: 1,
              ),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}

class TextFieldContainer2 extends StatelessWidget {
  final Widget child;

  TextFieldContainer2({required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 18),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text('Password',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: 'Gluten-Regular',
              ),
              textAlign: TextAlign.left),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: 1,
            ),
          ),
          child: child,
        ),
      ],
    );
  }
}

class TextFieldContainer3 extends StatelessWidget {
  final Widget child;

  TextFieldContainer3({required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: 1,
              color: const Color.fromARGB(221, 58, 57, 57),
            ),
          ),
          child: child,
        ),
      ],
    );
  }
}
