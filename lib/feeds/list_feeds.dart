import 'package:archery_club/authentication/storage_services.dart';
import 'package:archery_club/constant/brand_colors.dart';
import 'package:archery_club/feeds/create_feeds.dart';
import 'package:archery_club/feeds/detail_feeds.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedsList extends StatefulWidget {
  @override
  State<FeedsList> createState() => _FeedsListState();
}

class _FeedsListState extends State<FeedsList> {
  List<String>? currentFeedsImages = [];

  Future<List<String>> getImageURLfromPostID(String postID) async {
    final List<String> imageFeedsURL =
        await StorageServices().getImageFeedsURL(postID);

    print("Isi URL : $imageFeedsURL");
    return imageFeedsURL;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference posts = firestore.collection('posts');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: BrandColor.colorPrimary,
        title: const Text("Feeds"),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return CreateFeeds();
                },
              ));
            },
            icon: const Icon(
              Icons.add_to_photos,
              color: Colors.white,
            ),
            label: const Text(
              "Add Post",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            StreamBuilder<QuerySnapshot>(
              stream: posts.snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: snapshot.data!.docs.map<Widget>((doc) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return DetailFeedsScreen(
                                  caption: doc.data()['caption'],
                                  username: doc.data()['username'],
                                  uID: doc.id);
                            },
                          ));
                        },
                        child: Card(
                          color: Colors.white,
                          child: Column(
                            children: [
                              FutureBuilder<List<String>>(
                                future:
                                    StorageServices().getImageFeedsURL(doc.id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasData) {
                                    return Column(
                                      children: [
                                        Container(
                                          child: CarouselSlider(
                                            items: snapshot.data?.map((e) {
                                              return Image.network(e,
                                                  fit: BoxFit.contain);
                                            }).toList(),
                                            options: CarouselOptions(
                                                enableInfiniteScroll: false,
                                                aspectRatio: 1 / 1),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Text("Error");
                                  }
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        doc.data()['username'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(doc.data()["caption"]),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return const Text('Loading..');
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
