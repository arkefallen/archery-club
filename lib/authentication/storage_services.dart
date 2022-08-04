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
    // await FirebaseFirestore.instance
    //     .collection('posts')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((element) {
    //     listDownloadURL.add(element.id);
    //   });
    // });

    // Iterable<Future<ListResult>> filesResult =
    //     listDownloadURL.map((e) => cloudStorageRef.ref('posts/$e').listAll());
    print("ID Post : $postID");

    // ListResult result =
    //     await cloudStorageRef.ref('posts/$postID').listAll().then((value) {
    //   value.items.forEach((element) async {
    //     // String url = ;
    //     listDownloadURL.add(await element.getDownloadURL());
    //     // FutureBuilder(
    //     //   future: element.getDownloadURL(),
    //     //   builder: (context, snapshot) {
    //     //     if (snapshot.hasData) {
    //     //       listDownloadURL.add(snapshot.data);
    //     //       return Text("data")
    //     //     }
    //     //   },
    //     // );
    //   });
    //   print("Isi listdownloadurl : $listDownloadURL");
    //   return value;
    // });

    List<String> result = await cloudStorageRef
        .ref('posts/$postID')
        .listAll()
        .then((value) async {
      // value.items.forEach((element) async {
      //   String url = await element.getDownloadURL();
      //   print("Isi URL : $url");
      //   listDownloadURL.add(url.toString());
      //   print("Isi ListDownloadURL di foreach : $listDownloadURL");
      // });

      for (var i = 0; i < value.items.length; i++) {
        String url = await value.items[i].getDownloadURL();
        listDownloadURL.add(url);
      }

      // print("Isi Download URL : $listDownloadURL");
      return listDownloadURL;
    });

    // List<String> urlsResult = await listDownloadURL;

    print("Isi result : $result");
    return result;
  }

  // Future<String> getImageURL(String postID, String imageName) async {
  //   String downloadURL =
  //       await cloudStorageRef.ref('posts/$postID/$imageName').getDownloadURL();

  //   return downloadURL;
  // }

  // Future<List<String>> getAllFeeds() async {
  //   ListResult feedsResult = await cloudStorageRef.ref('posts/').listAll();

  //   var postDirectories = await _getDownloadLinks(feedsResult.prefixes);

  //   return postDirectories;
  // }

  // Future<List<String>> _getDownloadLinks(List<Reference> refs) async {
  //   List<String> listPostID = [];

  //   refs.forEach((element) {
  //     listPostID.add(element.name);
  //   });

  //   ListResult listImage =
  // }

  // getAllFeeds() async {
  //   final ref = cloudStorageRef.ref('posts');
  //   final resultAllPost = await ref.listAll();

  //   final resultPostID = resultAllPost.prefixes;

  //   final getAllImage = resultPostID.map((e) {
  //     Future.wait(e.getDownloadURL());
  //   }).toList();
  // }
}
