import 'package:archery_club/constant/brand_colors.dart';
import 'package:archery_club/feeds/list_feeds.dart';
import 'package:archery_club/members/members_list.dart';
import 'package:archery_club/profile/profile.dart';
import 'package:archery_club/workshop/list_workshops.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({required this.user});
  final User user;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List screens = [];

  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    screens = [
      const FeedsList(),
      const MembersList(),
      // const WorkshopList(),
      WorkshopList(user: widget.user),
      Profile(user: widget.user)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Member"),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_rounded), label: "Exercise"),
            // BottomNavigationBarItem(icon: Icon(Icons.track_changes), label: "Scoring"),
            BottomNavigationBarItem(
                icon: Icon(Icons.manage_accounts), label: "Profile")
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: BrandColor.colorPrimary,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
        ),
        body: screens[_selectedIndex]);
  }
}
