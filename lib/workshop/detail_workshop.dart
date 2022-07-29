import 'package:archery_club/constant/brand_colors.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:intl/intl.dart';

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
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Badge(
              //   badgeColor: BrandColor.colorPrimary,
              //   badgeContent: const Text("Location"),
              // ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  notes!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date"),
                  // Text(date!),

                  Text(DateFormat('d MMMM y').format(DateTime.parse(date!))),
                ],
              ),
              const Text("Start Time"),
              Text(startTime!),
              const Text("End Time"),
              Text(endTime!)
            ],
          ),
        ),
      ),
    );
  }
}
