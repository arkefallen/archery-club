import 'package:archery_club/feeds/edit_feeds.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:archery_club/constant/brand_colors.dart';

class DetailFeedsScreen extends StatelessWidget {
  DetailFeedsScreen(
      {required this.caption,
      required this.username,
      required this.images,
      required this.uID});

  String caption;
  String username;
  List<String>? images;
  String uID;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference posts = firestore.collection('posts');

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: [
                CarouselSlider(items: images?.map((e) => Image.network(e)).toList(), options: CarouselOptions(aspectRatio: 1/1,enableInfiniteScroll: false)),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: BrandColor.colorPrimary,
                      child: const BackButton(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                        color: BrandColor.colorPrimaryLight),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    caption,
                    style:
                        TextStyle(fontSize: 20.0, color: BrandColor.textColor),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return EditFeeds(
                            caption: caption,
                            username: username,
                            uID: uID);
                      }));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.green,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'EDIT DATA',
                          style: TextStyle(color: Colors.green),
                        )
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Konfirmasi'),
                              content: const Text("Anda yakin ingin menghapus data ?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("TIDAK")),
                                TextButton(
                                    onPressed: () {
                                      try {
                                        posts.doc(uID).delete();

                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    child: const Text("YA"))
                              ],
                            );
                          });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.delete,
                          size: 20,
                          color: Colors.red,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'HAPUS DATA',
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
