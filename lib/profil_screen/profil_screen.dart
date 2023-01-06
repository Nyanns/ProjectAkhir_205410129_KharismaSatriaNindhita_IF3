import 'dart:io';

import 'package:app/home_screen/home_screen.dart';
import 'package:app/log_in/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfilScreen extends StatefulWidget {
  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  String? name = '';
  String? email = '';
  String? image = '';
  String? phoneNo = '';
  File? imageXFile;

  Future _getDataFromDatabse() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (snapshot) async {
        if (snapshot.exists) {
          setState(
            () {
              name = snapshot.data()!['name'];
              email = snapshot.data()!['email'];
              image = snapshot.data()!['userImage'];
              phoneNo = snapshot.data()!['phoneNumber'];
            },
          );
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataFromDatabse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        shape: const Border(
          bottom:
              BorderSide(color: Color.fromARGB(255, 59, 59, 59), width: 0.8),
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 254, 254),
                Color.fromARGB(255, 248, 246, 246)
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Profil',
          style: TextStyle(
            fontSize: 24,
            color: Color.fromARGB(255, 43, 45, 45),
            //  fontFamily: 'Gluten-Regular',
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomeScreen(),
                    ),
                  );
                },
                child: const Icon(
                  size: 30,
                  color: Color.fromARGB(255, 43, 45, 45),
                  Icons.arrow_back_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 254, 254),
              Color.fromARGB(247, 221, 236, 252)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // show image Dialog
              },
              child: CircleAvatar(
                minRadius: 82,
                backgroundColor: Colors.black87,
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: imageXFile == null
                      ? NetworkImage(image!)
                      : Image.file(imageXFile!).image,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '' + name!,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    //  fontFamily: 'Gluten-Regular',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Email: ' + email!,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    //  fontFamily: 'Gluten-Regular',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Phone Number: ' + phoneNo!,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    //fontFamily: 'Gluten-Regular',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                    );
                  },
                  child: Text(
                    'LOGOUT',
                    style: TextStyle(color: Colors.black87, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(250, 40),
                    backgroundColor: Color.fromARGB(247, 173, 225, 255),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    elevation: 0,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
