import 'package:archery_club/constant/brand_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditFeeds extends StatelessWidget {
  String caption;
  String username;
  String images;
  String uID;

  EditFeeds(
      {required this.caption,
      required this.username,
      required this.images,
      required this.uID});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference posts = firestore.collection('posts');

    TextEditingController captionController =
        TextEditingController(text: caption);
    TextEditingController usernameController =
        TextEditingController(text: username);
    TextEditingController imagesController =
        TextEditingController(text: images);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(uID),
        backgroundColor: BrandColor.colorPrimary,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: captionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: "Caption",
                    hintText: "Buat caption semenarik mungkin",
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: "Nama",
                    hintText: "Masukkan nama kamu",
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: imagesController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: "Link Gambar",
                    hintText: "Masukkan link gambar untuk ditampilkan",
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    //// TODO : update data to firestore

                    try {
                      posts.doc(uID).update({
                        'caption': captionController.text,
                        'username': usernameController.text,
                        'images': imagesController.text
                      });

                      captionController.text = "";
                      usernameController.text = "";
                      imagesController.text = "";

                      Navigator.pop(context);
                      Navigator.pop(context);
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text('Update Result'),
                                content: Text("Proses gagal."),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Kembali'),
                                    child: Text('Kembali'),
                                  )
                                ],
                              ));
                    }
                  },
                  child: Text("UPDATE DATA"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
