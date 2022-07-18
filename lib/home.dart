import 'package:archery_club/constant/brand_colors.dart';
import 'package:archery_club/feeds/list_feeds.dart';
import 'package:archery_club/members/members_list.dart';
import 'package:archery_club/workshop/list_workshops.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List screens = [const FeedsList(), const MembersList(), const WorkshopList()];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Member"),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded),label: "Exercise"),
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
