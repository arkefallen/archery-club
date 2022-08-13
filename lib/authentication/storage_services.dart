import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StorageServices {
  final FirebaseStorage cloudStorageRef = FirebaseStorage.instance;

  uploadImageFeeds(List<PlatformFile>? imageList, String postID,
      BuildContext context) async {
    if (imageList != null) {
      imageList.forEach((element) async {
        String filename = element.name;
        File file = File(element.path!);

        try {
          await cloudStorageRef.ref('posts/$postID/$filename').putFile(file);
          print("Success insert ${element.path}");
        } on FirebaseException catch (e) {
          print(e.code);
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No files selected")),
      );
    }
  }

  Future<ListResult> getAllImage(String postID) async {
    final ListResult result =
        await cloudStorageRef.ref('/posts/$postID').listAll();

    return result;
  }

  Future<List<String>> getImageFeedsURL(String postID) async {
    List<String> listDownloadURL = [];

    List<String> result = await cloudStorageRef
        .ref('posts/$postID')
        .listAll()
        .then((value) async {
      for (var i = 0; i < value.items.length; i++) {
        String url = await value.items[i].getDownloadURL();
        listDownloadURL.add(url);
      }

      return listDownloadURL;
    });

    return result;
  }
}
