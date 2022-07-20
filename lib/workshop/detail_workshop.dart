import 'package:archery_club/constant/brand_colors.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class DetailWorkshop extends StatelessWidget {
  String? notes;
  String? date;
  String? startTime;
  String? endTime;

  DetailWorkshop(
      {required this.notes,
      required this.date,
      required this.startTime,
      required this.endTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
        backgroundColor: BrandColor.colorPrimary,
        title: const Text("Workshop Detail"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Badge(
              badgeColor: BrandColor.colorPrimary,
              badgeContent: const Text("Location"),
            ),
            Text(
              notes!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24
              ),
            ),
            const Text("Date"),
            Text(
              date!
            ),
            const Text(
              "Start Time"
            ),
            Text(startTime!),
            const Text("End Time"),
            Text(endTime!)
          ],
        ),
      ),
    );
  }
}
