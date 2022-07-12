import 'package:archery_club/feeds/edit_feeds.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:archery_club/constant/brand_colors.dart';

class DetailMembersScreen extends StatelessWidget {
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
        title: Text("Members Detail", style: TextStyle(color: BrandColor.colorPrimary),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          const Text(
                            'Rafeyfa Ammara Wijaya',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Perempuan',
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
              padding : const EdgeInsets.all(15.0),
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const ListTile(
                            title: Text("Pekerjaan"),
                            subtitle: Text("Software Enginer"),
                          ),
                          const ListTile(
                            title: Text("Pekerjaan"),
                            subtitle: const Text("Software Enginer"),
                          ),
                        ],
                      )
                    ],
                  ),
            )
            )
          ],
        ),
      ),
    );
  }
}
