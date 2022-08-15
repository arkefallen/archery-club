import 'dart:ffi';

import 'package:archery_club/constant/brand_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class ListAttendance extends StatefulWidget {
  String? workshop_id;

  ListAttendance({required this.workshop_id});

  @override
  State<ListAttendance> createState() => _ListAttendanceState();
}

class _ListAttendanceState extends State<ListAttendance> {
  @override
  Widget build(BuildContext context) {
    // FirebaseFirestore firestore = FirebaseFirestore.instance;
    // CollectionReference presence = firestore.collection('presence');
    Stream<QuerySnapshot> presence = FirebaseFirestore.instance
        .collection('presence')
        .where('workshop_id', isEqualTo: widget.workshop_id)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: BrandColor.colorPrimary,
        title: Text("List Attendance"),
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          // stream: presence
          //     .where('workshop_id', isEqualTo: widget.workshop_id)
          //     .snapshots(),
          stream: presence,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return CheckboxListTile(
                        title: Text(data['user_name']),
                        value: data['presence'],
                        onChanged: (bool? value) {
                          FirebaseFirestore.instance
                              .collection('presence')
                              .doc(document.id)
                              .update({'presence': value!});
                        });
                  });
              // return Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: snapshot.data.docs.map<Widget>((doc) {
              //     return ListTile(
              //       title: Text(doc.data()['user_name']),
              //       trailing: Checkbox(
              //         value: doc.data()['presence'],
              //         onChanged: (value) {
              //           setState(() {
              //             doc.data()['presence'] = value!;
              //           });
              //         },
              //       ),
              //     );
              //   }).toList(),
              // );
            } else {
              return const Center(
                child: Text("Loading"),
              );
            }
          }),
    );
  }
}
