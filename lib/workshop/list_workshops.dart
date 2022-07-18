import 'package:archery_club/constant/brand_colors.dart';
import 'package:archery_club/workshop/create_workshop.dart';
import 'package:flutter/material.dart';

class WorkshopList extends StatelessWidget {
  const WorkshopList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BrandColor.colorPrimary,
        title: const Text("Workshop Schedule"),
        actions: [
          TextButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateWorkshop()));
              },
              icon: const Icon(Icons.add_circle_outline,color: Colors.white),
              label: const Text("Add", style: TextStyle(color: Colors.white),),
          )
        ],
      ),
    );
  }
}
