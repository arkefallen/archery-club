import 'package:archery_club/constant/brand_colors.dart';
import 'package:archery_club/workshop/create_workshop.dart';
import 'package:archery_club/workshop/detail_workshop.dart';
import 'package:archery_club/workshop/edit_workshop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkshopList extends StatefulWidget {
  // const WorkshopList({Key? key, required this.user}) : super(key: key);
  const WorkshopList({required this.user});
  final User user;

  @override
  State<WorkshopList> createState() => _WorkshopListState();
}

class _WorkshopListState extends State<WorkshopList> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference workshops = firestore.collection('workshops');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: BrandColor.colorPrimary,
        title: const Text("Workshop Schedule"),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateWorkshop()));
            },
            icon: const Icon(Icons.add_circle_outline, color: Colors.white),
            label: const Text(
              "Add",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: BrandColor.greyBackground,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: StreamBuilder<QuerySnapshot>(
              stream: workshops.orderBy('date', descending: true).snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: snapshot.data.docs.map<Widget>((doc) {
                      return InkWell(
                        onTap: () {
                          // print(widget.user);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => DetailWorkshop(
                                      user: widget.user,
                                      id: doc.id,
                                      notes: doc.data()['notes'],
                                      location: doc.data()['location'],
                                      date: doc.data()['date'],
                                      startTime: doc.data()['start_time'],
                                      endTime: doc.data()['end_time']))));
                        },
                        child: Card(
                          elevation: 4,
                          child: ListTile(
                              leading: const Icon(
                                Icons.document_scanner_outlined,
                                size: 30,
                              ),
                              title: Text(
                                doc.data()['notes'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat('d MMMM y').format(
                                          DateTime.parse(doc.data()['date'])),
                                      // doc.data()['date'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Row(
                                      children: [
                                        Text(DateFormat('HH:mm').format(
                                            DateTime.parse(
                                                doc.data()['start_time']))),
                                        Text(' - '),
                                        Text(DateFormat('HH:mm').format(
                                            DateTime.parse(
                                                doc.data()['end_time']))),
                                      ],
                                    )
                                    // Text(
                                    //     "${doc.data()['start_time']} - ${doc.data()['end_time']}")
                                  ]),
                              isThreeLine: true,
                              trailing: PopupMenuButton<MenuItem>(
                                onSelected: (item) => onSelected(
                                    context,
                                    item,
                                    doc.id,
                                    doc.data()['notes'],
                                    doc.data()['location'],
                                    doc.data()['date'],
                                    doc.data()['start_time'],
                                    doc.data()['end_time']),
                                itemBuilder: (context) => [
                                  ...MenuItems.itemFirst.map(buildItem).toList()
                                ],
                              )),
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return const Center(
                    child: Text("Loading ..."),
                  );
                }
              },
            ),
          ),
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
            // color: Colors.black,
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
    String id,
    String notes,
    String location,
    String date,
    String startTime,
    String endTime,
  ) {
    setState(() {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference workshops = firestore.collection('workshops');
      if (item == MenuItems.itemEdit) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return EditWorkshop(
                id: id,
                notes: notes,
                location: location,
                date: date,
                start_time: startTime,
                end_time: endTime);
          },
        ));
      } else {
        workshops.doc(id).delete();
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
  static const List<MenuItem> itemFirst = [itemEdit, itemDelete];

  static const itemEdit = MenuItem(text: 'Edit', icon: Icons.edit);
  static const itemDelete = MenuItem(text: 'Delete', icon: Icons.delete);
}
