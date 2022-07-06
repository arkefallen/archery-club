import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  TextEditingController captionController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstImgController = TextEditingController();
  TextEditingController secondImgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference posts = firestore.collection('posts');
    
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Feeds Baru'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
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
                  controller: firstImgController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: "Link Gambar 1",
                    hintText: "Masukkan link gambar untuk ditampilkan",
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: secondImgController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: "Link Gambar 2",
                    hintText: "Masukkan link gambar untuk ditampilkan",
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      //// TODO : add data to firestore

                      try {
                        posts.add({
                          'caption': captionController.text,
                          'username': usernameController.text,
                          'images': [
                            firstImgController.text,
                            secondImgController.text
                          ]
                        });

                        captionController.text = "";
                        usernameController.text = "";
                        firstImgController.text = "";
                        secondImgController.text = "";

                        Navigator.pop(context);
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text('Insert Result'),
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
                    child: Text("TAMBAH DATA"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
