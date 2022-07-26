import 'package:archery_club/constant/brand_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateFeeds extends StatelessWidget {
  TextEditingController captionController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController imagesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference posts = firestore.collection('posts');
    CollectionReference user_posts = firestore.collection('user_posts');

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: BrandColor.colorPrimary,
        title: const Text('Feeds Baru'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                const SizedBox(height: 20),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: "Nama",
                    hintText: "Masukkan nama kamu",
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: imagesController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: "Link Gambar",
                    hintText: "Masukkan link gambar untuk ditampilkan",
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            BrandColor.colorPrimary)),
                    onPressed: () {
                      User? currentUser = Provider.of<User?>(context,listen: false);

                      try {
                        posts.add({
                          'user_id': currentUser?.uid,
                          'caption': captionController.text,
                          'username': usernameController.text,
                          'images': imagesController.text
                        }).then(
                          (value) => user_posts.add({
                              'user_id': currentUser?.uid,
                              'post_id': value.id
                            })
                        );

                        captionController.text = "";
                        usernameController.text = "";
                        imagesController.text = "";

                        Navigator.pop(context);
                      } catch (e) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Insert Result'),
                                  content: const Text("Proses gagal."),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Kembali'),
                                      child: const Text('Kembali'),
                                    )
                                  ],
                                ));
                      }
                    },
                    child: const Text("TAMBAH DATA"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
