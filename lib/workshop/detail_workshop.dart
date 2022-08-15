import 'package:archery_club/constant/brand_colors.dart';
import 'package:archery_club/workshop/presence/list_attendance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:intl/intl.dart';

class DetailWorkshop extends StatefulWidget {
  final User user;
  String? id;
  String? notes;
  String? location;
  String? date;
  String? startTime;
  String? endTime;

  DetailWorkshop({
    required this.user,
    required this.id,
    required this.notes,
    required this.location,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  @override
  State<DetailWorkshop> createState() => _DetailWorkshopState();
}

class _DetailWorkshopState extends State<DetailWorkshop> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference presence = firestore.collection('presence');
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
        actions: <Widget>[
          PopupMenuButton<MenuItem>(
            onSelected: (item) => onSelected(
              context,
              item,
              widget.id.toString(),
            ),
            itemBuilder: (context) =>
                [...MenuItems.itemFirst.map(buildItem).toList()],
          )
        ],
        backgroundColor: BrandColor.colorPrimary,
        title: const Text("Workshop Detail"),
      ),
      body: Container(
        // color: Colors.grey,
        margin: EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badge(
            //   badgeColor: BrandColor.colorPrimary,
            //   badgeContent: const Text("Location"),
            // ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              child: Text(
                widget.notes!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),

            Text(
              "Date",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(DateFormat('d MMMM y').format(DateTime.parse(widget.date!))),
            SizedBox(
              height: 10,
            ),
            Text(
              "Location",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(widget.location!),

            SizedBox(
              height: 10,
            ),
            const Text("Start Time",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            Text(DateFormat('HH:mm').format(DateTime.parse(widget.startTime!))),
            SizedBox(
              height: 10,
            ),
            const Text("End Time",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            Text(DateFormat('HH:mm').format(DateTime.parse(widget.endTime!))),
            SizedBox(
              height: 20,
            ),
            Container(
              // alignment: Alignment.centerRight,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: BrandColor.colorPrimary,
                      minimumSize: const Size.fromHeight(40)),
                  onPressed: () {
                    try {
                      presence.add({
                        'user_name': widget.user.displayName,
                        'user_email': widget.user.email,
                        'workshop_id': widget.id,
                        'workshop_name': widget.notes!,
                        'created_at': DateTime.now().toString(),
                        'presence': true,
                      });
                      // print(widget.user.displayName);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text('Insert Result'),
                                content: const Text("Presence Succes"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Back'),
                                    child: const Text('Back'),
                                  )
                                ],
                              ));
                      ;
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text('Insert Result'),
                                content: const Text("Failed to Presence"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Back'),
                                    child: const Text('Back'),
                                  )
                                ],
                              ));
                    }
                  },
                  child: const Text("Attend")),
            )
          ],
        ),
      ),
    );
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem<MenuItem>(
      value: item,
      child: Row(
        children: [
          Icon(
            item.icon,
            color: Colors.black,
            size: 20,
          ),
          SizedBox(
            width: 20,
          ),
          Text(item.text),
        ],
      ));
  void onSelected(
    BuildContext context,
    MenuItem item,
    String workshop_id,
  ) {
    setState(() {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference workshops = firestore.collection('workshops');
      if (item == MenuItems.itemAttendance) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ListAttendance(workshop_id: workshop_id);
        }));
      } else {
        print("input");
      }
    });
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> itemFirst = [itemAttendance];

  static const itemAttendance =
      MenuItem(text: 'List Attendance', icon: Icons.list_alt);
  // static const itemInputAttendance =
  //     MenuItem(text: 'Input Attendance', icon: Icons.add);
}
