import 'dart:developer';

import 'package:archery_club/constant/brand_colors.dart';
import 'package:archery_club/scoring/scoring_list.dart';
import 'package:archery_club/scoring/widget/scrollable_widget.dart';
import 'package:archery_club/scoring/widget/text_dialog_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:archery_club/scoring/scoring_edit.dart';
import 'package:provider/provider.dart';

class MenuItem {
  final String? text;
  final IconData? icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> item = [
    itemEdit,
    itemDelete,
  ];

  static const itemEdit = MenuItem(text: 'Edit', icon: Icons.edit_note_sharp);
  static const itemDelete =
      MenuItem(text: 'Delete', icon: Icons.delete_outline_outlined);
}

class ScoringDetails extends StatefulWidget {
  ScoringDetails(
      {Key? key,
      required this.id,
      required this.name,
      required this.arrow,
      required this.createdOn,
      required this.bow,
      required this.distance,
      required this.face,
      required this.round,
      required this.scors})
      : super(key: key);

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
  State<ScoringDetails> createState() => _ScoringDetailsState();
}

class _ScoringDetailsState extends State<ScoringDetails> {
  PopupMenuItem<MenuItem> buildItem(MenuItem item) {
    return PopupMenuItem<MenuItem>(
      value: item,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              item.icon,
              color: Colors.black,
              size: 20,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(item.text.toString()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference scoring = firestore.collection('scoring');


    List<DataColumn> getColumns(List<String> columns) {
      return columns.map((String column) {
        return DataColumn(
            label: Container(
                alignment: Alignment.center, width: 50, child: Text(column)));
      }).toList();
    }

    List<DataCell> getCells(Map cell, int round) {
      List map = cell["round"];
      List<DataCell> cells = [];

      for (var cell in map) {
        cells.add(DataCell(Container(
            alignment: Alignment.center, child: Text(cell.toString()))));
      }

      cells[cells.length - 1] = DataCell(
        Container(
          alignment: Alignment.center,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
              child: Icon(Icons.add_box),
              onTap: () {
                showTextDialog(context,
                    id: widget.id, arrow: widget.arrow, round: round);
              },
            ),
            InkWell(
              child: Icon(Icons.remove_circle_rounded),
              onTap: () {
                scoring
                    .doc(widget.id)
                    .get()
                    .then((DocumentSnapshot documentSnapshot) {
                  if (documentSnapshot.exists) {
                    Map data = documentSnapshot.data() as Map;
                    List scorsData = data['scors'] as List;
                    scorsData[round]['round'] = List.filled(widget.arrow, 0);
                    scoring.doc(widget.id).update({
                      'scors': scorsData,
                    });
                    Navigator.pop(context);
                  } else {
                    print('Document does not exist on the database');
                  }
                });
              },
            )
          ]),
        ),
      );
      return cells;
    }

    List<DataRow> getRows(List<dynamic> row) {
      List<DataRow> dataRow = [];
      int index = 0;
      for (var row in row) {
        dataRow.add(DataRow(cells: getCells(row, index)));
        index++;
      }
      return dataRow;
    }

    num totalScore = 0;
    for (var eachRow in widget.scors) {
      num total = 0;
      for (var i = 0; i < eachRow["round"].length; i++) {
        total += eachRow["round"][i];
      }
      totalScore += total;
    }

    Widget buildDataTable() {
      List<String> columns = List.filled(widget.arrow + 2, "").toList();
      for (var i = 0; i < widget.arrow; i++) {
        columns[i] = "Arrow ${i + 1}";
      }
      columns[columns.length - 2] = "Total";
      columns[columns.length - 1] = "AKSI";

      List rows = widget.scors;

      for (var eachRow in rows) {
        num total = 0;
        for (var i = 0; i < eachRow["round"].length; i++) {
          total += eachRow["round"][i];
        }
        eachRow["round"] = [...eachRow["round"], total.toString(), "AKSI"];
      }

      return DataTable(columns: getColumns(columns), rows: getRows(rows));
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: BrandColor.colorPrimary,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        title: Text("Scoreboard"),
        actions: [
          PopupMenuButton<MenuItem>(
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              ...MenuItems.item.map((buildItem)),
            ],
          ),
        ],
      ),
      body: Container(
          margin: EdgeInsets.all(15),
          child: ListView(
            children: [
              StreamBuilder<Object>(
                  stream: scoring.doc(widget.id).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                          widget.name +
                              DateFormat(' (dd MMMM yyyy)')
                                  .format(widget.createdOn),
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500)),
                    );
                  }),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Jumlah Anak Panah: " + widget.arrow.toString(),
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Jumlah Putaran: " +
                                  widget.round.toString() +
                                  " ronde",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Jarak: " + widget.distance.toString() + " meter",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Target Face: " + widget.face,
                                style: TextStyle(fontSize: 15),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Jenis Busur: " + widget.bow,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Card(
                  elevation: 3,
                  margin: EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: Text(
                            "Skoring",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                              child: Text(
                                "Total Skor : ",
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                "${totalScore.toString()}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        ScrollableWidget(child: buildDataTable()),
                      ],
                    ),
                  )),
            ],
          )),
    );
  }

  void onSelected(BuildContext context, MenuItem item) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference scoring = firestore.collection('scoring');
    switch (item.text) {
      case 'Edit':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scoring_edit(
              id: widget.id,
              name: widget.name,
              arrow: widget.arrow,
              createdOn: widget.createdOn,
              bow: widget.bow,
              distance: widget.distance,
              face: widget.face,
              round: widget.round,
              scors: widget.scors,
            ),
          ),
        );
        break;
      case 'Delete':
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Hapus Data Skoring'),
            content: Text('Apakah anda yakin ingin menghapus data ini?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Tidak'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Ya'),
                onPressed: () {
                  scoring.doc(widget.id).delete();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  ;
                },
              ),
            ],
          ),
        );
        break;
    }
  }
}
