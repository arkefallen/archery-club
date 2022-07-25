import 'package:archery_club/constant/brand_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class EditMembers extends StatefulWidget {
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

  EditMembers({
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
  State<EditMembers> createState() => _EditMembersState();
}

class _EditMembersState extends State<EditMembers> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference members = firestore.collection('members');

    TextEditingController nameController =
        TextEditingController(text: widget.name);

    TextEditingController phoneController =
        TextEditingController(text: widget.phone);

    TextEditingController emailController =
        TextEditingController(text: widget.email);

    TextEditingController addressController =
        TextEditingController(text: widget.address);

    TextEditingController jobController =
        TextEditingController(text: widget.job);

    TextEditingController nikController =
        TextEditingController(text: widget.nik);

    TextEditingController genderController =
        TextEditingController(text: widget.gender);

    TextEditingController roleController =
        TextEditingController(text: widget.role);

    TextEditingController bornDateController =
        TextEditingController(text: widget.birthDate);

    TextEditingController joinDateController =
        TextEditingController(text: widget.joinDate);
    TextEditingController birthDateController =
        TextEditingController(text: widget.birthDate);

    String? genderValue = widget.gender;
    String? roleValue = widget.role;

    DateTime bornDate = DateTime.parse(widget.joinDate!);
    DateTime joinDate = DateTime.parse(widget.birthDate!);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: BrandColor.colorPrimary,
        title: const Text('Edit Member Information'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    labelText: "Name",
                    hintText: "Type the name of new member",
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  maxLength: 16,
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    labelText: "Phone Number",
                    hintText: "example : 08123456789",
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    labelText: "Email",
                    hintText: "example : user@mail.com",
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  maxLines: 2,
                  controller: addressController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    labelText: "Address",
                    hintText: "example : Jalan Mawar No.10",
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      labelText: "Gender",
                      hintText: "Choose the member's gender",
                    ),
                    value: genderValue,
                    items: <String>['-', 'Male', 'Female']
                        .map<DropdownMenuItem<String>>((String gender) {
                      return DropdownMenuItem<String>(
                        child: Text(gender),
                        value: gender,
                      );
                    }).toList(),
                    onChanged: (String? newGenderValue) {
                      setState(() {
                        genderValue = newGenderValue;
                        genderController.text = newGenderValue!;
                        widget.gender = newGenderValue;
                      });
                    }),
                const SizedBox(height: 20),
                DateTimeField(
                  onChanged: (value) {
                    setState(() {
                      joinDateController.text = value.toString();
                    });
                  },
                  initialValue: bornDate,
                  format: DateFormat("dd-MM-yyyy"),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        initialDate: currentValue ?? DateTime.now(),
                        firstDate: DateTime(1945),
                        lastDate: DateTime(2100));
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    labelText: "Join Date",
                    hintText: "Choose the date when joined the club",
                  ),
                ),
                const SizedBox(height: 20),
                DateTimeField(
                  onChanged: (value) {
                    setState(() {
                      bornDateController.text = value.toString();
                    });
                  },
                  initialValue: joinDate,
                  format: DateFormat("dd-MM-yyyy"),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        initialDate: currentValue ?? DateTime.now(),
                        firstDate: DateTime(1945),
                        lastDate: DateTime(2100));
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    labelText: "Birth Date",
                    hintText: "Choose the birth date",
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: jobController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    labelText: "Job",
                    hintText: "example : Software Engineer",
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  maxLength: 16,
                  controller: nikController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    labelText: "NIK",
                    hintText: "Input the NIK's member on ID Card",
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      labelText: "Role",
                      hintText: "Pick the authorization of member",
                    ),
                    value: roleValue,
                    items: <String>['-', 'Administrator', 'Member']
                        .map<DropdownMenuItem<String>>((String role) {
                      return DropdownMenuItem<String>(
                        child: Text(role),
                        value: role,
                      );
                    }).toList(),
                    onChanged: (String? newRoleValue) {
                      setState(() {
                        roleValue = newRoleValue;
                        roleController.text = newRoleValue!;
                        widget.role = newRoleValue;
                      });
                    }),
                const SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: BrandColor.colorPrimary,
                        minimumSize: Size.fromHeight(50)),
                    onPressed: () {
                      try {
                        members.doc(widget.id).update({
                          'name': nameController.text,
                          'phone': phoneController.text,
                          'email': emailController.text,
                          'address': addressController.text,
                          'gender': genderController.text,
                          'job': jobController.text,
                          'nik': nikController.text,
                          'role': roleController.text,
                          'birth_date': bornDateController.text,
                          'join_date': joinDateController.text,
                        });

                        nameController.text = '';
                        phoneController.text = '';
                        emailController.text = '';
                        addressController.text = '';
                        genderController.text = '';
                        jobController.text = '';
                        nikController.text = '';
                        roleController.text = '';
                        bornDateController.text = '';
                        joinDateController.text = '';

                        Navigator.pop(context);
                        Navigator.pop(context);
                      } catch (e) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Insert Result'),
                                  content:
                                      const Text("Failed to add new member"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Back'),
                                      child: const Text('Back'),
                                    )
                                  ],
                                ));
                      }
                    },
                    child: const Text("UPDATE MEMBER")),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
