import 'dart:io';
import 'package:app/log_in/login_screen.dart';
import 'package:app/owner_detail/owner_details.dart';
import 'package:app/profil_screen/profil_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? changeTitle = 'Miku';
  bool checkView = false;

  File? imageFile;
  String? imageUrl;
  String? myName;
  String? myImage;

  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  void _upload_image() async {
    if (imageFile == null) {
      Fluttertoast.showToast(msg: "Pilih Foto Dulu!!!");
      return;
    }
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('userImages')
          .child(DateTime.now().toString() + "jpg");
      await ref.putFile(imageFile!);
      imageUrl = await ref.getDownloadURL();
      FirebaseFirestore.instance
          .collection("wallpaper")
          .doc(DateTime.now().toString())
          .set(
        {
          'id': _auth.currentUser!.uid,
          'email': _auth.currentUser!.email,
          'image': imageUrl,
          'downloads': 0,
          'userImage': myImage,
          'name': myName,
          'createdAt': DateTime.now(),
        },
      );
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      imageFile = null;
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  void read_userInfo() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then<dynamic>(
      (DocumentSnapshot snapshot) async {
        myImage = snapshot.get('userImage');
        myName = snapshot.get('name');
      },
    );
  }

  @override
  void initState() {
    // TODO : implement initstate
    super.initState();
    read_userInfo();
  }

  Widget ListViewWidget(String docId, String img, String userImg, String name,
      DateTime date, String userId, int downloads) {
    return Card(
      child: Container(
        padding: const EdgeInsets.only(bottom: 0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1),
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255)
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OwnerDetails(
                          img: img,
                          userImg: userImg,
                          name: name,
                          date: date,
                          docId: docId,
                          userId: userId,
                          downloads: downloads,
                        ),
                      ),
                    );
                  },
                  child: Image.network(
                    img,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 2,
                  right: 0,
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        userImg,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: 'Gluten-Regular',
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          DateFormat('dd MMM, yyy - hh:mm a')
                              .format(date)
                              .toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            fontFamily: 'Gluten-Regular',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget GridViewWidget(String docId, String img, String userImg, String name,
      DateTime date, String userId, int downloads) {
    return GridView.count(
      primary: false,
      padding: EdgeInsets.all(0),
      crossAxisSpacing: 1,
      crossAxisCount: 1,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Color.fromARGB(57, 135, 135, 135),
              style: BorderStyle.solid,
            ),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 63, 63, 63),
                Color.fromARGB(255, 63, 63, 63)
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          padding: const EdgeInsets.all(0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => OwnerDetails(
                    img: img,
                    userImg: userImg,
                    name: name,
                    date: date,
                    docId: docId,
                    userId: userId,
                    downloads: downloads,
                  ),
                ),
              );
            },
            child: Center(
              child: Image.network(
                img,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 244, 254, 255),
            Color.fromARGB(255, 232, 232, 232)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Scaffold(
        floatingActionButton: Wrap(
          direction: Axis.horizontal,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton(
                child: const Icon(
                  Icons.add_sharp,
                  size: 30,
                ),
                elevation: 0,
                splashColor: const Color.fromARGB(255, 125, 125, 125),
                backgroundColor: Color.fromARGB(255, 71, 73, 74),
                heroTag: "1",
                onPressed: () {
                  _showImageDialog();
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton(
                child: const Icon(
                  Icons.adobe_rounded,
                  size: 30,
                ),
                elevation: 0,
                splashColor: Color.fromARGB(255, 67, 67, 67),
                backgroundColor: Color.fromARGB(255, 71, 73, 74),
                heroTag: "2",
                onPressed: () {
                  _upload_image();
                },
              ),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 90),
              /*
              CircleAvatar(
                radius: 13,
                backgroundImage: AssetImage('images/mikikimikik.png'),
                backgroundColor: Color.fromRGBO(255, 255, 255, 0),
              ), 
              */
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    changeTitle = "Miku";
                    checkView = true;
                  });
                },
                onDoubleTap: (() {
                  setState(() {
                    changeTitle = "Miku";
                    checkView = false;
                  });
                }),
                child: Text(
                  changeTitle!,
                  style: TextStyle(
                    fontSize: 32,
                    color: Color.fromARGB(255, 43, 45, 45),
                    fontFamily: 'Gluten-Regular',
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LoginScreen(),
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
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfilScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.supervised_user_circle_rounded,
                size: 30,
                color: Color.fromARGB(255, 43, 45, 45),
              ),
            )
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('wallpaper')
              .orderBy("createdAt", descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (streamSnapshot.connectionState ==
                ConnectionState.active) {
              if (streamSnapshot.data!.docs.isNotEmpty) {
                if (checkView == true) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListViewWidget(
                        streamSnapshot.data!.docs[index].id,
                        streamSnapshot.data!.docs[index]['image'],
                        streamSnapshot.data!.docs[index]['userImage'],
                        streamSnapshot.data!.docs[index]['name'],
                        streamSnapshot.data!.docs[index]['createdAt'].toDate(),
                        streamSnapshot.data!.docs[index]['id'],
                        streamSnapshot.data!.docs[index]['downloads'],
                      );
                    },
                  );
                } else {
                  return GridView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return GridViewWidget(
                        streamSnapshot.data!.docs[index].id,
                        streamSnapshot.data!.docs[index]['image'],
                        streamSnapshot.data!.docs[index]['userImage'],
                        streamSnapshot.data!.docs[index]['name'],
                        streamSnapshot.data!.docs[index]['createdAt'].toDate(),
                        streamSnapshot.data!.docs[index]['id'],
                        streamSnapshot.data!.docs[index]['downloads'],
                      );
                    },
                  );
                }
              } else {
                return const Center(
                  child: Text(
                    'There is no task',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Gluten-Regular',
                      fontSize: 20,
                    ),
                  ),
                );
              }
            }
            return const Center(
              child: Text(
                'Somethong went wrong',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Gluten-Regular',
                  fontSize: 20,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
