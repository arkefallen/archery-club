import 'package:flutter/material.dart';
import 'feeds.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'constant/brand_colors.dart';

class DetailFeedsScreen extends StatelessWidget {
  const DetailFeedsScreen({required this.feedsList});

  final Feed feedsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: BackButton(onPressed: () => Navigator.pop(context)),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
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
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: BrandColor.colorPrimary,
                      child: BackButton(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    feedsList.username,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                      color: BrandColor.colorPrimaryLight
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    feedsList.caption,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: BrandColor.textColor
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


