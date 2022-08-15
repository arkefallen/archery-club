import 'dart:ui';

import 'package:archery_club/scoring/data/target_face.dart';
import 'package:archery_club/scoring/data/target_face_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:archery_club/constant/brand_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:archery_club/scoring/scoring_create.dart';

class CreateTargetFace extends StatelessWidget {
  TextEditingController nameFaceController = TextEditingController(text: "");
  TextEditingController imageUrlFaceController =
      TextEditingController(text: "");
  TextEditingController heightFaceController = TextEditingController(text: "");
  TextEditingController widthFaceController = TextEditingController(text: "");

  TextEditingController colorController_1 = TextEditingController(text: "");
  TextEditingController colorController_2 = TextEditingController(text: "");
  TextEditingController colorController_3 = TextEditingController(text: "");
  TextEditingController colorController_4 = TextEditingController(text: "");
  TextEditingController colorController_5 = TextEditingController(text: "");
  TextEditingController colorController_6 = TextEditingController(text: "");
  TextEditingController colorController_7 = TextEditingController(text: "");
  TextEditingController colorController_8 = TextEditingController(text: "");
  TextEditingController colorController_9 = TextEditingController(text: "");
  TextEditingController colorController_10 = TextEditingController(text: "0");
  TextEditingController pointController_1 = TextEditingController(text: "0");
  TextEditingController pointController_2 = TextEditingController(text: "0");
  TextEditingController pointController_3 = TextEditingController(text: "0");
  TextEditingController pointController_4 = TextEditingController(text: "0");
  TextEditingController pointController_5 = TextEditingController(text: "0");
  TextEditingController pointController_6 = TextEditingController(text: "0");
  TextEditingController pointController_7 = TextEditingController(text: "0");
  TextEditingController pointController_8 = TextEditingController(text: "0");
  TextEditingController pointController_9 = TextEditingController(text: "0");
  TextEditingController pointController_10 = TextEditingController(text: "0");

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
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
        title: Text('Create Target Face'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
                alignment: Alignment.topCenter,
                child: Text(
                  'Create Target Face',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Nama Target Face",
                    hintText: "Ex. WA Full",
                    floatingLabelStyle:
                        TextStyle(color: BrandColor.colorPrimary, fontSize: 20),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: BrandColor.colorPrimary, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: BrandColor.colorPrimary),
                        borderRadius: BorderRadius.circular(10))),
                controller: nameFaceController,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Link Foto Target Face",
                    hintText: "Ex. https://www.google.com/",
                    floatingLabelStyle:
                        TextStyle(color: BrandColor.colorPrimary, fontSize: 20),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: BrandColor.colorPrimary, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: BrandColor.colorPrimary),
                        borderRadius: BorderRadius.circular(10))),
                controller: imageUrlFaceController,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150,
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: "Tinggi",
                            hintText: "Ex. 150",
                            suffixText: "Cm",
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
                        controller: heightFaceController,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: "Lebar",
                            hintText: "Ex. 150",
                            suffixText: "Cm",
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
                        controller: widthFaceController,
                      ),
                    ),
                  ]),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        'Point Target Face',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            pointTargetFace(
                                colorController_1, pointController_1),
                            pointTargetFace(
                                colorController_2, pointController_2),
                            pointTargetFace(
                                colorController_3, pointController_3),
                            pointTargetFace(
                                colorController_4, pointController_4),
                            pointTargetFace(
                                colorController_5, pointController_5),
                            pointTargetFace(
                                colorController_6, pointController_6),
                            pointTargetFace(
                                colorController_7, pointController_7),
                            pointTargetFace(
                                colorController_8, pointController_8),
                            pointTargetFace(
                                colorController_9, pointController_9),
                            pointTargetFace(
                                colorController_10, pointController_10),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(4),
                  minimumSize: MaterialStateProperty.all(Size.fromHeight(50)),
                  backgroundColor:
                      MaterialStateProperty.all(BrandColor.colorPrimary),
                ),
                onPressed: () {
                  targetFace.add(TargetFace(
                      name: nameFaceController.text,
                      imageUrl: imageUrlFaceController.text,
                      heightInCm: int.parse(heightFaceController.text),
                      widthInCm: int.parse(widthFaceController.text),
                      point: pointTarget([])).toMap());
                  Navigator.pop(context);
                },
                child: Text(
                  "Create",
                  style: TextStyle(fontSize: 20),
                )),
          ]),
        ),
      ),
    );
  }

  List pointTarget(List point) {
    point.add(TargetFacePoint(
            id: '1',
            color: colorController_1.text,
            value: int.parse(pointController_1.text))
        .toMap());
    point.add(TargetFacePoint(
            id: '2',
            color: colorController_2.text,
            value: int.parse(pointController_2.text))
        .toMap());
    point.add(TargetFacePoint(
            id: '3',
            color: colorController_3.text,
            value: int.parse(pointController_3.text))
        .toMap());
    point.add(TargetFacePoint(
            id: '4',
            color: colorController_4.text,
            value: int.parse(pointController_4.text))
        .toMap());
    point.add(TargetFacePoint(
            id: '5',
            color: colorController_5.text,
            value: int.parse(pointController_5.text))
        .toMap());
    point.add(TargetFacePoint(
            id: '6',
            color: colorController_6.text,
            value: int.parse(pointController_6.text))
        .toMap());
    point.add(TargetFacePoint(
            id: '7',
            color: colorController_7.text,
            value: int.parse(pointController_7.text))
        .toMap());
    point.add(TargetFacePoint(
            id: '8',
            color: colorController_8.text,
            value: int.parse(pointController_8.text))
        .toMap());
    point.add(TargetFacePoint(
            id: '9',
            color: colorController_9.text,
            value: int.parse(pointController_9.text))
        .toMap());
    point.add(TargetFacePoint(
            id: '10',
            color: colorController_10.text,
            value: int.parse(pointController_10.text))
        .toMap());

    return point;
  }

  Column pointTargetFace(TextEditingController colorController,
      TextEditingController pointController) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(10, 10, 20, 10),
          child: SizedBox(
            width: 100,
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Warna",
                  floatingLabelStyle:
                      TextStyle(color: BrandColor.colorPrimary, fontSize: 20),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: BrandColor.colorPrimary, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: BrandColor.colorPrimary),
                      borderRadius: BorderRadius.circular(10))),
              controller: colorController,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(10, 10, 20, 10),
          child: SizedBox(
            width: 100,
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Skor",
                  floatingLabelStyle:
                      TextStyle(color: BrandColor.colorPrimary, fontSize: 20),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: BrandColor.colorPrimary, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: BrandColor.colorPrimary),
                      borderRadius: BorderRadius.circular(10))),
              controller: pointController,
            ),
          ),
        ),
      ],
    );
  }
}
