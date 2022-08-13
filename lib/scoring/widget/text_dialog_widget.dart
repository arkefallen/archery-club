import 'package:archery_club/constant/brand_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<T?> showTextDialog<T>(
  BuildContext context, {
  required String id,
  required int arrow,
  required int round,
}) =>
    showDialog<T>(
      context: context,
      builder: (context) => TextDialogWidget(
          title: "Tambah Skor", id: id, arrow: arrow, round: round),
    );

class TextDialogWidget extends StatefulWidget {
  final String title;
  final String id;
  final int arrow;
  final int round;

  const TextDialogWidget(
      {Key? key,
      required this.title,
      required this.id,
      required this.arrow,
      required this.round})
      : super(key: key);

  @override
  State<TextDialogWidget> createState() => _TextDialogWidgetState();
}

class _TextDialogWidgetState extends State<TextDialogWidget> {
  List<TextEditingController> controllers = [];

  List<TextEditingController> _controllers() {
    for (int i = 0; i < widget.arrow; i++) {
      controllers.add(TextEditingController(text: ""));
    }
    return controllers;
  }

  TextEditingController nameController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference scoring = firestore.collection('scoring');

    // scoring.doc(widget.id).get().then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     print('Document data: ${documentSnapshot.data()}');
    //   } else {
    //     print('Document does not exist on the database');
    //   }
    // });

    int arrow = 0;
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            ..._controllers().map((controller) {
              arrow++;
              return SizedBox(
                width: 50,
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: "Skor ${arrow}",
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              scoring
                  .doc(widget.id)
                  .get()
                  .then((DocumentSnapshot documentSnapshot) {
                if (documentSnapshot.exists) {
                  List scor = controllers
                      .map((controller) => int.parse(controller.text))
                      .toList();
                  Map data = documentSnapshot.data() as Map;
                  List scorsData = data['scors'] as List;
                  scorsData[widget.round]['round'] = scor;
                  scoring.doc(widget.id).update({
                    'scors': scorsData,
                  });
                  Navigator.pop(context);
                } else {
                  print('Document does not exist on the database');
                }
              });
            },
            child: Text("Tambah"))
      ],
    );
  }
}
