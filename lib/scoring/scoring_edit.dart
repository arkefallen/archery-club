import 'package:archery_club/constant/brand_colors.dart';
import 'package:archery_club/scoring/data/scoring.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Scoring_edit extends StatefulWidget {
  Scoring_edit({
    Key? key,
    required this.id,
    required this.name,
    required this.arrow,
    required this.createdOn,
    required this.bow,
    required this.distance,
    required this.face,
    required this.round,
    required this.scors,
  }) : super(key: key);

  String id;
  String name;
  int arrow;
  DateTime createdOn;
  String bow;
  int distance;
  String face;
  int round;
  List<dynamic> scors;

  @override
  State<Scoring_edit> createState() => _Scoring_editState();
}

class _Scoring_editState extends State<Scoring_edit> {
  TextEditingController roundController = TextEditingController();

  TextEditingController bowController = TextEditingController();

  TextEditingController faceController = TextEditingController();

  TextEditingController arrowController = TextEditingController();

  TextEditingController distanceController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference scoring = firestore.collection('scoring');
    CollectionReference targetFace = firestore.collection('targetFace');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: BrandColor.colorPrimary,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        title: Text("Edit Data Skoring"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                  controller: nameController =
                      TextEditingController(text: widget.name),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                  controller: distanceController =
                      TextEditingController(text: widget.distance.toString()),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                  controller: bowController =
                      TextEditingController(text: widget.bow),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                  controller: arrowController =
                      TextEditingController(text: widget.arrow.toString()),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                  controller: roundController =
                      TextEditingController(text: widget.round.toString()),
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
                                isEmpty: faceController.text == '',
                                child: Column(
                                  children: snapshot.data!.docs.map((e) {
                                    return Card(
                                        elevation: 3,
                                        child: Column(children: [
                                          ListTile(
                                            selected: e["name"] ==
                                                faceController.text,
                                            selectedColor:
                                                BrandColor.colorPrimary,
                                            onTap: () {
                                              setState(() {
                                                faceController.text = e['name'];
                                                widget.arrow = int.parse(
                                                    arrowController.text);
                                                widget.round = int.parse(
                                                    roundController.text);
                                                widget.bow = bowController.text;
                                                widget.distance = int.parse(
                                                    distanceController.text);
                                                widget.name =
                                                    nameController.text;
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
                  alignment: Alignment(0.8, 0.9),
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

                        scoring.doc(widget.id).set({
                          'name': nameController.text,
                          'round': int.tryParse(roundController.text) ?? 6,
                          'bow': bowController.text,
                          'targetFace': faceController.text,
                          'arrow': int.tryParse(arrowController.text) ?? 6,
                          'distance':
                              int.tryParse(distanceController.text) ?? 200,
                          'createdOn': FieldValue.serverTimestamp(),
                          'scors': scorsRound
                        });

                        Navigator.pop(context);
                      },
                      child: Text("Ubah",
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
