import 'package:archery_club/constant/brand_colors.dart';
import 'package:archery_club/feeds/list_feeds.dart';
import 'package:archery_club/members/members_list.dart';

import 'feeds/create_feeds.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List screens = [const FeedsList(), const MembersList()];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Member"),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: BrandColor.colorPrimary,
          onTap: (index) {
            setState( () {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
        ),
        body: screens[_selectedIndex]);
  }
}
