import 'package:archery_club/constant/brand_colors.dart';
import 'package:archery_club/home.dart';
import 'package:flutter/material.dart';

class MembersList extends StatefulWidget {
  const MembersList({Key? key}) : super(key: key);

  @override
  State<MembersList> createState() => _MembersListState();
}

class _MembersListState extends State<MembersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daftar Anggota Klub",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: BrandColor.colorPrimary,
        actions: <Widget>[
          PopupMenuButton<String>(
            // onSelected: (ActionMenuList menu) {
            //   setState(() {
            //     _selectedActionMenu = menu.name;
            //   });
            // },
            onSelected: (value) => _selectedMenu(value, context),
            itemBuilder: (context) {
              return Menu.choices.map((String choice) {
                return PopupMenuItem(
                  child: Text(choice),
                  value: choice,
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: const CircleAvatar(),
                title: Text("Anggota ${index + 1}"),
                subtitle: const Text("Subtitle"),
                trailing: const Text("Lihat Detail"),
              ),
            );
          },
        ),
      ),
    );
  }

  void _selectedMenu(String choice, BuildContext context) {
    setState(() {
      if (choice == Menu.addMember) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
      }
    });
  }
}

class Menu {
  static const String addMember = 'Add New Member';
  static const String excelMigration = 'Excel Migration';

  static const List<String> choices = <String>[addMember, excelMigration];
}
