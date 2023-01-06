import 'package:app/widget/text_field_continer.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final bool obscureText;
  final TextEditingController textEditingController;

  const InputField({
    required this.obscureText,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: Column(
        children: [
          TextField(
            cursorColor: Colors.black,
            obscureText: obscureText,
            controller: textEditingController,
            decoration: const InputDecoration(
              helperStyle: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: "Gluten-Regular",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InputField2 extends StatelessWidget {
  final bool obscureText;
  final TextEditingController textEditingController;

  const InputField2({
    required this.obscureText,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer2(
      child: Column(
        children: [
          TextField(
            cursorColor: Colors.black,
            obscureText: obscureText,
            controller: textEditingController,
            decoration: const InputDecoration(
              helperStyle: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: "Gluten-Regular",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InputField3 extends StatelessWidget {
  final bool obscureText;
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;

  const InputField3({
    required this.hintText,
    required this.icon,
    required this.obscureText,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer3(
      child: Column(
        children: [
          TextField(
            cursorColor: Colors.black,
            obscureText: obscureText,
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: hintText,
              helperStyle: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "Gluten-Regular",
              ),
              prefixIcon: Icon(
                icon,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
