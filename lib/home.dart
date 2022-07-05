import 'package:archery_club/detail_feeds.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

import 'main.dart';
import 'post.dart';
import 'feeds.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/img/logo.png',
          width: 220,
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          Feed feedsList = postFeeds[index];
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return DetailFeedsScreen(feedsList: feedsList);
                  },
                ));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                child: Column(
                  children: [
                    CarouselSlider(
                      items: feedsList.photos.map((img) {
                        return Builder(builder: (BuildContext builder) {
                          return Image.network(img);
                        });
                      }).toList(),
                      options: CarouselOptions(
                        aspectRatio: 1 / 1,
                        viewportFraction: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              feedsList.username,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(feedsList.caption),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        child: Container(
          width: 90,
          child: Row(
            children: [
              Icon(Icons.add),
              Text('Add Post'),
            ],
          ),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Post();
            },
          ));
        },
      ),
    );
  }
}
