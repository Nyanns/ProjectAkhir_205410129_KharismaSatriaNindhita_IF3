import 'dart:io';
import 'package:app/account_check/account_check.dart';
import 'package:app/home_screen/home_screen.dart';
import 'package:app/log_in/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/widget/bottom_square.dart';
import 'package:app/widget/input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Credentials extends StatefulWidget {
  @override
  State<Credentials> createState() => _CredentialsState();
}

class _CredentialsState extends State<Credentials> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController _fullNameControler =
      TextEditingController(text: '');
  final TextEditingController _emailTextControler =
      TextEditingController(text: '');
  final TextEditingController _passControler = TextEditingController(text: '');
  final TextEditingController _phoneNumControler =
      TextEditingController(text: '');

  File? imageFile;
  String? imageUrl;

  void _showImageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Please choose an option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  _getFrontCamera();
                },
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.camera,
                        color: Color.fromRGBO(154, 217, 227, 1),
                      ),
                    ),
                    Text(
                      "Camera",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Gluten-Regular',
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _getFrontGallery();
                },
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.image,
                        color: Color.fromRGBO(154, 217, 227, 1),
                      ),
                    ),
                    Text(
                      "Gallery",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Gluten-Regular',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _getFrontCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFrontGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            _showImageDialog();
          },
          child: CircleAvatar(
            backgroundImage: imageFile == null
                ? const AssetImage("images/miku4.png")
                : Image.file(imageFile!).image,
            backgroundColor: const Color.fromRGBO(255, 255, 255, 0),
            radius: 80,
          ),
        ),
        const SizedBox(height: 8),
        const Divider(
          color: Colors.black,
          thickness: 3,
        ),
        const SizedBox(height: 8),
        InputField3(
          hintText: "Masukkan Namamu!",
          icon: Icons.person_sharp,
          obscureText: false,
          textEditingController: _fullNameControler,
        ),
        const SizedBox(height: 8),
        InputField3(
          hintText: "Masukkan Emailmu!",
          icon: Icons.email_rounded,
          obscureText: false,
          textEditingController: _emailTextControler,
        ),
        const SizedBox(height: 8),
        InputField3(
          hintText: "Buat Password!",
          icon: Icons.vpn_key,
          obscureText: true,
          textEditingController: _passControler,
        ),
        const SizedBox(height: 8),
        InputField3(
          hintText: "No Telepon!",
          icon: Icons.phone_iphone_outlined,
          obscureText: false,
          textEditingController: _phoneNumControler,
        ),
        const SizedBox(height: 8),
        ButtonSquare(
          text: "Register",
          press: () async {
            if (imageFile == null) {
              Fluttertoast.showToast(msg: "Tap Miku Dulu (-_-)!");
              return;
            }
            try {
              final ref = FirebaseStorage.instance
                  .ref()
                  .child('userImages')
                  .child('${DateTime.now()}.jpg');
              await ref.putFile(imageFile!);
              imageUrl = await ref.getDownloadURL();
              await auth.createUserWithEmailAndPassword(
                email: _emailTextControler.text.trim().toLowerCase(),
                password: _passControler.text.trim(),
              );
              final User? user = auth.currentUser;
              final _uid = user!.uid;
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(_uid)
                  .set({
                'id': _uid,
                'userImage': imageUrl,
                'name': _fullNameControler.text,
                'email': _emailTextControler.text,
                'phoneNumber': _phoneNumControler.text,
                'createdAt': Timestamp.now(),
              });
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            } catch (error) {
              Fluttertoast.showToast(msg: error.toString());
            }
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HomeScreen(),
              ),
            );
          },
        ),
        const SizedBox(
          height: 8,
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
        ),
      ],
    );
  }
}
