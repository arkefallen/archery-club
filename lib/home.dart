import 'feeds/detail_feeds.dart';
import 'feeds/create_feeds.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference posts = firestore.collection('posts');

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home" 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Member",
          )
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/img/logo.png',
          width: 220,
        ),
        backgroundColor: Colors.white,
      ),
      body:
          SingleChildScrollView(
            child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: StreamBuilder<QuerySnapshot>(
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
                                images: doc.data()['images'],
                                uID: doc.id
                            );
                          },
                        ));
                      },
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Image.network(doc.data()['images']),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                ),
          ),
      // ListView.builder(
      //   itemCount: 3,
      //   itemBuilder: (context, index) {
      //     Feed feedsList = postFeeds[index];S
      //     return Padding(
      //       padding: EdgeInsets.all(10.0),
      //       child:
      //       InkWell(
      //         onTap: () {
      //           Navigator.push(context, MaterialPageRoute(
      //             builder: (BuildContext context) {
      //               return DetailFeedsScreen(feedsList: feedsList);
      //             },
      //           ));
      //         },
      //         child: Card(
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(10.0),
      //           ),
      //           color: Colors.white,
      //           child: Column(
      //             children: [
      //               CarouselSlider(
      //                 items: feedsList.photos.map((img) {
      //                   return Builder(builder: (BuildContext builder) {
      //                     return Image.network(img);
      //                   });
      //                 }).toList(),
      //                 options: CarouselOptions(
      //                   aspectRatio: 1 / 1,
      //                   viewportFraction: 1,
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.stretch,
      //                   children: [
      //                     Padding(
      //                       padding: const EdgeInsets.only(left: 8.0),
      //                       child: Text(
      //                         feedsList.username,
      //                         style: TextStyle(fontWeight: FontWeight.bold),
      //                       ),
      //                     ),
      //                     Padding(
      //                       padding: const EdgeInsets.all(8.0),
      //                       child: Text(feedsList.caption),
      //                     )
      //                   ],
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
      floatingActionButton: ElevatedButton(
        child: Container(
          width: 90,
          child: Row(
            children: const [
              Icon(Icons.add),
              Text('Add Post'),
            ],
          ),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return CreateFeeds();
            },
          ));
        },
      ),
    );
  }
}
