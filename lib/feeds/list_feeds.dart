import 'package:archery_club/authentication/storage_services.dart';
import 'package:archery_club/constant/brand_colors.dart';
import 'package:archery_club/feeds/create_feeds.dart';
import 'package:archery_club/feeds/detail_feeds.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FeedsList extends StatefulWidget {
  @override
  State<FeedsList> createState() => _FeedsListState();
}

class _FeedsListState extends State<FeedsList> {
  // final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<List<String>> getImageURLfromPostID(String postID) async {
    final List<String> imageFeedsURL =
        await StorageServices().getImageFeedsURL(postID);
    // imageFeedsURL.then((value) {
    //   urls.add(value);
    //   print("Isi url : ${value.toString()}");
    // });

    // imageFeedsURL.forEach((element) {
    //   urls.add(element);
    // });

    print("Isi URL : $imageFeedsURL");
    return imageFeedsURL;
  }

  // Future getDirectories() async {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference posts = firestore.collection('posts');

    List<String>? currentFeedsImages;

    // Future<ListResult> allPosts =
    //     FirebaseStorage.instance.ref('posts/').listAll();

    // print(getDirectories());

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
                                  images: currentFeedsImages,
                                  uID: doc.id);
                            },
                          ));
                        },
                        child: Card(
                          color: Colors.white,
                          child: Column(
                            children: [
                              // Image.network(doc.data()['images']),
                              FutureBuilder<List<String>>(
                                future:
                                    StorageServices().getImageFeedsURL(doc.id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasData) {
                                    currentFeedsImages = snapshot.data;
                                    return CarouselSlider(
                                      items: snapshot.data
                                          ?.map((e) => Image.network(e))
                                          .toList(),
                                      options: CarouselOptions(
                                          aspectRatio: 4 / 5,
                                          enableInfiniteScroll: false),
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
            // FutureBuilder(
            //   future: allPosts,
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     print(StorageServices().getAllPost());
            //     final tes = StorageServices().getAllPost();
            //     return Column(
            //       children: [
            //         Text('Isi post : ${StorageServices().getAllPost()}')
            //       ],
            //     );
            //   },
            // )
          ]),
        ),
      ),
    );
  }
}
