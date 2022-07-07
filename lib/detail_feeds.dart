import 'package:archery_club/edit_feeds.dart';
import 'package:flutter/material.dart';
import 'feeds.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'constant/brand_colors.dart';

class DetailFeedsScreen extends StatelessWidget {
  DetailFeedsScreen(
      {required this.caption,
      required this.username,
      required this.images,
      required this.uID});

  String caption;
  String username;
  String images;
  String uID;

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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                      return EditFeeds(
                          caption: caption,
                          username: username,
                          images: images,
                          uID: uID);
                    }));
                  },
                  child: Row(
                    children: [
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
                  onPressed: () {},
                  child: Row(
                    children: [
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
            )
          ],
        ),
      ),
    );
  }
}
