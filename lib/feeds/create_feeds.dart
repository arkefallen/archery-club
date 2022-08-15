import 'dart:io';

import 'package:archery_club/authentication/storage_services.dart';
import 'package:archery_club/constant/brand_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:provider/provider.dart';

class CreateFeeds extends StatefulWidget {
  @override
  State<CreateFeeds> createState() => _CreateFeedsState();
}

class _CreateFeedsState extends State<CreateFeeds> {
  TextEditingController captionController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController imagesController = TextEditingController();

  List<PlatformFile>? listImage;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference posts = firestore.collection('posts');
    CollectionReference userPosts = firestore.collection('user_posts');

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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                OutlinedButton.icon(
                  onPressed: () async {
                    // List<XFile>? result = await ImagePicker().pickMultiImage();
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
                            allowMultiple: true,
                            allowedExtensions: ['png', 'jpg', 'jpeg'],
                            type: FileType.custom);

                    setState(() {
                      listImage = result?.files;
                      print("Isi List Image : $listImage");
                    });
                  },
                  icon: const Icon(Icons.upload),
                  label: const Text("Pick Images"),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                ),
                listImage != null
                    ? Row(
                        children: listImage
                            ?.map((img) => Image.file(File(img.path!),
                                width: 50, height: 50, fit: BoxFit.cover))
                            .toList() as List<Widget>)
                    : const SizedBox(height: 5),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    User? currentUser =
                        Provider.of<User?>(context, listen: false);

                    String? currentPostID;

                    try {
                      posts.add({
                        'user_id': currentUser?.uid,
                        'caption': captionController.text,
                        'username': usernameController.text,
                        'images': 'https://picsum.photos/id/237/500/500'
                      }).then((value) {
                        userPosts.add(
                            {'user_id': currentUser?.uid, 'post_id': value.id});
                        currentPostID = value.id;
                        StorageServices().uploadImageFeeds(
                            listImage, currentPostID!, context);
                      });

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
                      print("Error : ${e.toString()}");
                      posts.doc(currentPostID).delete();
                    }
                  },
                  child: const Text("TAMBAH DATA"),
                  style: ElevatedButton.styleFrom(
                      primary: BrandColor.colorPrimary,
                      minimumSize: const Size.fromHeight(50)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
