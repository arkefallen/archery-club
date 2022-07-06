import 'package:flutter/material.dart';
import 'feeds.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'constant/brand_colors.dart';

class DetailFeedsScreen extends StatelessWidget {

  DetailFeedsScreen({
    required this.caption,
    required this.username,
    required this.images
  });

  String caption;
  String username;
  String images;

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
                Image.network(images),
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
                    username,
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                        color: BrandColor.colorPrimaryLight),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    caption,
                    style:
                        TextStyle(fontSize: 20.0, color: BrandColor.textColor),
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
