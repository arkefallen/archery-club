import 'package:archery_club/constant/brand_colors.dart';
import 'package:archery_club/workshop/create_workshop.dart';
import 'package:archery_club/workshop/detail_workshop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WorkshopList extends StatelessWidget {
  const WorkshopList({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: StreamBuilder<QuerySnapshot>(
            stream: workshops.snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: snapshot.data.docs.map<Widget>((doc) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => DetailWorkshop(
                                    notes: doc.data()['notes'],
                                    date: doc.data()['date'],
                                    startTime: doc.data()['start_time'],
                                    endTime: doc.data()['end_time']))));
                      },
                      child: ListTile(
                        leading: const Icon(Icons.pin_drop),
                        title: Text(
                          doc.data()['notes'],
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(doc.data()['date']),
                        trailing: Text(
                            "${doc.data()['start_time']} - ${doc.data()['end_time']}"),
                      ),
                    );
                  }).toList(),
                );
              } else {
                return const Center(
                  child: Text("Data not found"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
