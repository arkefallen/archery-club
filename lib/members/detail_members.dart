import 'package:archery_club/members/edit_members.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: 
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: ClipOval(
                        child: Image.asset('assets/img/user.png'),
                      ),
                    ),
                    SizedBox(height: 15),
                    Column(
                      children: [
                        Text(
                          name!,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign:TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          gender!,
                          style: TextStyle(
                            color: BrandColor.colorPrimaryLight,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              const SizedBox(height: 5),
                              Text(
                                job!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Role',
                                style: TextStyle(
                                    color: BrandColor.hintColor, fontSize: 14),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                role!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
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
                              const SizedBox(height: 5),
                              Text(
                                phone!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email',
                                style: TextStyle(
                                    color: BrandColor.hintColor, fontSize: 14),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                email!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
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
                              const SizedBox(height: 5),
                              Text(
                                birthDate!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Join Date',
                                style: TextStyle(
                                    color: BrandColor.hintColor, fontSize: 14),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                joinDate!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
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
                              const SizedBox(height: 5),
                              Text(
                                address!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'NIK',
                                style: TextStyle(
                                    color: BrandColor.hintColor, fontSize: 14),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                nik!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                                return EditMembers(
                                  id: id, 
                                  name: name, 
                                  phone: phone, 
                                  email: email, 
                                  address: address,
                                  gender: gender, 
                                  birthDate: birthDate, 
                                  joinDate: joinDate, 
                                  job: job, 
                                  role: role, 
                                  nik: nik
                                );
                              }
                            )
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.green,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'EDIT DATA',
                              style: TextStyle(color: Colors.green),
                            )
                          ],
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Confirmation'),
                                  content: const Text("Are you sure want to remove the data ?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("NO")),
                                    TextButton(
                                        onPressed: () {
                                          try {
                                            members.doc(id).delete();
                      
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          } catch (e) {
                                            print(e);
                                          }
                                        },
                                        child: const Text("YA"))
                                  ],
                                );
                              });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.delete,
                              size: 20,
                              color: Colors.red,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'REMOVE DATA',
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}
