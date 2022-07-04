import 'package:carousel_slider/carousel_slider.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

import 'main.dart';
import 'post.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _faker = new Faker();

  List<String> imgItems = [
    "https://picsum.photos/id/237/500/500",
    "https://picsum.photos/id/238/500/500",
    "https://picsum.photos/id/239/500/500"
  ];

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
          return Card(
            color: Colors.white,
            child: Column(
              children: [
                CarouselSlider(
                  items: imgItems.map((img) {
                    return Builder(builder: (BuildContext context) {
                      return Image.network(img);
                    });
                  }).toList(),
                  options: CarouselOptions(
                      aspectRatio: 1 / 1, viewportFraction: 1, height: 400),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        faker.internet.userName(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(faker.lorem.sentence()),
                    )
                  ],
                )
              ],
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
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Post();
          },))
        },
      ),
    );
  }
}
