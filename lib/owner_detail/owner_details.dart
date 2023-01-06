import 'package:app/home_screen/home_screen.dart';
import 'package:app/widget/bottom_square.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:intl/intl.dart';

class OwnerDetails extends StatefulWidget {
  String? img;
  String? name;
  String? userImg;
  String? docId;
  String? userId;
  DateTime? date;
  int? downloads;

  OwnerDetails({
    this.img,
    this.name,
    this.userImg,
    this.docId,
    this.userId,
    this.date,
    this.downloads,
  });

  @override
  State<OwnerDetails> createState() => _OwnerDetailsState();
}

class _OwnerDetailsState extends State<OwnerDetails> {
  int? total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 10),
        child: FloatingActionButton(
          child: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
          elevation: 0,
          splashColor: Color.fromARGB(255, 67, 67, 67),
          backgroundColor: Color.fromARGB(255, 71, 73, 74),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
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
            child: ListView(
              children: [
                Column(
                  children: [
                    Container(
                      color: Color.fromARGB(255, 104, 168, 200),
                      child: Column(
                        children: [
                          Container(
                            child: Image.network(
                              widget.img!,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      "Owner Information",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        // fontFamily: 'Gluten-Regular',
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.userImg!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "" + widget.name!,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: 'Gluten-Regular',
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      DateFormat('dd MMM, yyy - hh:mm a')
                          .format(widget.date!)
                          .toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontFamily: 'Gluten-Regular',
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.download_outlined,
                          size: 35,
                          color: Colors.black,
                        ),
                        Text(
                          " " + widget.downloads!.toString(),
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                            fontFamily: 'Gluten-Regular',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      child: ButtonSquare(
                        text: 'Download',
                        press: () async {
                          try {
                            var imageId = await ImageDownloader.downloadImage(
                                widget.img!);
                            if (imageId == null) {
                              return;
                            }
                            Fluttertoast.showToast(
                                msg: "Image saved to Gallery");
                            total = widget.downloads! + 1;

                            FirebaseFirestore.instance
                                .collection('wallpaper')
                                .doc(widget.docId)
                                .update({'downloads': total}).then(
                              (value) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => HomeScreen()),
                                );
                              },
                            );
                          } on PlatformException catch (error) {
                            print(error);
                          }
                        },
                      ),
                    ),
                    FirebaseAuth.instance.currentUser!.uid == widget.userId
                        ? Padding(
                            padding: EdgeInsets.only(left: 8, right: 8),
                            child: ButtonSquare(
                              text: 'Delete',
                              press: () async {
                                FirebaseFirestore.instance
                                    .collection('wallpaper')
                                    .doc(widget.docId)
                                    .delete()
                                    .then(
                                  (value) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => HomeScreen()),
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        : Container()
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
