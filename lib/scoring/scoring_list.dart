import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:archery_club/constant/brand_colors.dart';
import 'package:archery_club/scoring/scoring_create.dart';
import 'package:archery_club/scoring/detail_scoring.dart';
import 'package:archery_club/scoring/target_face/create_target_face.dart';
import 'package:archery_club/constant/brand_colors.dart';

class Scoring extends StatefulWidget {
  const Scoring({Key? key}) : super(key: key);

  @override
  State<Scoring> createState() => _ScoringState();
}

class _ScoringState extends State<Scoring> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference scoring = firestore.collection('scoring');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BrandColor.colorPrimary,
        title: Text("Amanah Archery"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scoring_create(),
                ),
              );
            },
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(BrandColor.colorPrimary),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateTargetFace(),
                ),
              );
            },
            child: Row(
              children: [
                Icon(
                  Icons.track_changes,
                ),
                SizedBox(width: 10),
                Text("Target Face"),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Skoring Pribadi",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return new Text("There is no expense");
                    return new Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        children: snapshot.data!.docs.map((e) {
                          return Card(
                              margin: EdgeInsets.only(bottom: 15),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ScoringDetails(
                                          id: e.id,
                                          name: e['name'],
                                          round: e['round'],
                                          bow: e['bow'],
                                          face: e['targetFace'],
                                          arrow: e['arrow'],
                                          distance: e['distance'],
                                          createdOn: e['createdOn'].toDate(),
                                          scors: e['scors'],
                                        ),
                                      ),
                                    );
                                  },
                                  leading: Icon(Icons.adjust_rounded, size: 50),
                                  title: e['createdOn'] == null
                                      ? Text(DateFormat('dd MMMM yyyy')
                                          .format(DateTime.now()))
                                      : Text(DateFormat('dd MMMM yyyy')
                                          .format(e["createdOn"].toDate())),
                                  subtitle: Text(
                                    e["name"],
                                    style: TextStyle(color: Colors.lightBlue),
                                  ),
                                  trailing: e['createdOn'] == null
                                      ? Text(DateFormat('kk:mm WIB')
                                          .format(DateTime.now()))
                                      : Text(DateFormat('kk:mm WIB')
                                          .format(e["createdOn"].toDate())),
                                )
                              ]));
                        }).toList(),
                      ),
                    );
                  },
                  stream: scoring.orderBy('createdOn').snapshots()),
            ],
          ),
        )),
      ),
    );
  }
}
