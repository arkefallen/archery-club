import 'package:archery_club/feeds/edit_feeds.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:archery_club/constant/brand_colors.dart';

class DetailMembersScreen extends StatelessWidget {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? address;
  String? gender;
  String? birthDate;
  String? joinDate;
  String? job;
  String? role;
  String? nik;

  DetailMembersScreen({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.gender,
    required this.birthDate,
    required this.joinDate,
    required this.job,
    required this.role,
    required this.nik,
  });

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference members = firestore.collection('members');

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: BrandColor.colorPrimary,
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Members Detail",
          style: TextStyle(color: BrandColor.colorPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: ClipOval(
                        child: Image.asset('assets/img/user.png'),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name!,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          gender!,
                          style: TextStyle(
                            color: BrandColor.colorPrimaryLight,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Job',
                              style: TextStyle(
                                  color: BrandColor.hintColor, fontSize: 14),
                            ),
                            SizedBox(height: 5),
                            Text(
                              job!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Role',
                              style: TextStyle(
                                  color: BrandColor.hintColor, fontSize: 14),
                            ),
                            SizedBox(height: 5),
                            Text(
                              role!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone',
                              style: TextStyle(
                                  color: BrandColor.hintColor, fontSize: 14),
                            ),
                            SizedBox(height: 5),
                            Text(
                              phone!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                  color: BrandColor.hintColor, fontSize: 14),
                            ),
                            SizedBox(height: 5),
                            Text(
                              email!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Birth Date',
                              style: TextStyle(
                                  color: BrandColor.hintColor, fontSize: 14),
                            ),
                            SizedBox(height: 5),
                            Text(
                              birthDate!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Join Date',
                              style: TextStyle(
                                  color: BrandColor.hintColor, fontSize: 14),
                            ),
                            SizedBox(height: 5),
                            Text(
                              joinDate!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address',
                              style: TextStyle(
                                  color: BrandColor.hintColor, fontSize: 14),
                            ),
                            SizedBox(height: 5),
                            Text(
                              address!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'NIK',
                              style: TextStyle(
                                  color: BrandColor.hintColor, fontSize: 14),
                            ),
                            SizedBox(height: 5),
                            Text(
                              nik!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ))
        ]),
      ),
    );
  }
}
