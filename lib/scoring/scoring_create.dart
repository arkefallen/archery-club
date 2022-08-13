import 'package:archery_club/constant/brand_colors.dart';
import 'package:archery_club/scoring/data/target_face.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'data/scoring.dart';

class Scoring_create extends StatefulWidget {
  @override
  State<Scoring_create> createState() => _Scoring_createState();
}

class _Scoring_createState extends State<Scoring_create> {
  TextEditingController nameController = TextEditingController(text: "");

  TextEditingController distanceController = TextEditingController(text: "");

  TextEditingController bowController = TextEditingController(text: "");

  TextEditingController arrowController = TextEditingController(text: "");

  TextEditingController roundController = TextEditingController(text: "");

  TextEditingController nameFaceController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference targetFace = firestore.collection('targetFace');
    CollectionReference scoring = firestore.collection('scoring');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: BrandColor.colorPrimary,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        title: Text("Amanah Archery"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Nama Lengkap",
                      hintText: "Ex. John Doe",
                      floatingLabelStyle: TextStyle(
                          color: BrandColor.colorPrimary, fontSize: 20),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: BrandColor.colorPrimary, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: BrandColor.colorPrimary),
                          borderRadius: BorderRadius.circular(10))),
                  controller: nameController,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextField(
                  decoration: InputDecoration(
                      suffixText: "Meter",
                      labelText: "Jarak",
                      floatingLabelStyle: TextStyle(
                          color: BrandColor.colorPrimary, fontSize: 20),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: BrandColor.colorPrimary, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: BrandColor.colorPrimary),
                          borderRadius: BorderRadius.circular(10))),
                  controller: distanceController,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Jenis Busur",
                      hintText: "Ex. PSE Fever",
                      floatingLabelStyle: TextStyle(
                          color: BrandColor.colorPrimary, fontSize: 20),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: BrandColor.colorPrimary, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: BrandColor.colorPrimary),
                          borderRadius: BorderRadius.circular(10))),
                  controller: bowController,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Jumlah Arrow",
                      floatingLabelStyle: TextStyle(
                          color: BrandColor.colorPrimary, fontSize: 20),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: BrandColor.colorPrimary, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: BrandColor.colorPrimary),
                          borderRadius: BorderRadius.circular(10))),
                  controller: arrowController,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "Total Ronde",
                      hintText: "Ex. 6",
                      floatingLabelStyle: TextStyle(
                          color: BrandColor.colorPrimary, fontSize: 20),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: BrandColor.colorPrimary, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: BrandColor.colorPrimary),
                          borderRadius: BorderRadius.circular(10))),
                  controller: roundController,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Target Face",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: StreamBuilder<QuerySnapshot>(
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData)
                                return new Text("There is no expense");
                              return InputDecorator(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                                isEmpty: nameFaceController.text == '',
                                child: Column(
                                  children: snapshot.data!.docs.map((e) {
                                    return Card(
                                        elevation: 3,
                                        child: Column(children: [
                                          ListTile(
                                            selected: e["name"] ==
                                                nameFaceController.text,
                                            selectedColor:
                                                BrandColor.colorPrimary,
                                            onTap: () {
                                              setState(() {
                                                nameFaceController.text =
                                                    e['name'];
                                              });
                                            },
                                            leading: Icon(Icons.track_changes,
                                                size: 50),
                                            title: Text(e['name']),
                                          )
                                        ]));
                                  }).toList(),
                                ),
                              );
                            },
                            stream: targetFace.snapshots()),
                      ),
                    ],
                  )),
              Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(Size.fromHeight(50)),
                          elevation: MaterialStateProperty.all(5),
                          backgroundColor: MaterialStateProperty.all(
                              BrandColor.colorPrimary)),
                      onPressed: () {
                        List scorsRound = [];
                        for (var i = 1;
                            i <= int.parse(roundController.text);
                            i++) {
                          scorsRound.add({
                            "round":
                                List.filled(int.parse(arrowController.text), 0)
                                    .toList()
                          });
                        }

                        final scor = Skoring(
                          targetFace: nameFaceController.text,
                          name: nameController.text,
                          distance: int.parse(distanceController.text),
                          bow: bowController.text,
                          arrow: int.parse(arrowController.text),
                          round: int.parse(roundController.text),
                          scors: scorsRound,
                        ).toMap();
                        scor.addAll(
                            {"createdOn": FieldValue.serverTimestamp()});
                        scoring.add(scor);
                        Navigator.pop(context);
                      },
                      child: Text("Tambah",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold))))
            ],
          ),
        ),
      ),
    );
  }
}
