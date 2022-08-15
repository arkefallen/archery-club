import 'package:archery_club/constant/brand_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditWorkshop extends StatefulWidget {
  String? id;
  String? notes;
  String? location;
  String? date;
  String? start_time;
  String? end_time;

  EditWorkshop({
    required this.id,
    required this.notes,
    required this.location,
    required this.date,
    required this.start_time,
    required this.end_time,
  });

  @override
  State<EditWorkshop> createState() => _EditWorkshopState();
}

class _EditWorkshopState extends State<EditWorkshop> {
  TextEditingController notesController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference workshop = firestore.collection('workshops');

    DateTime eventDate = DateTime.parse(widget.date!);
    DateTime eventStartTime = DateTime.parse(widget.start_time!);
    DateTime eventEndTime = DateTime.parse(widget.end_time!);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: BrandColor.colorPrimary,
          title: const Text('Edit Workshop Schedule'),
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.white,
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: notesController =
                          TextEditingController(text: widget.notes),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          labelText: "Notes",
                          hintText: "e.g. workshop name"),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: locationController =
                          TextEditingController(text: widget.location),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          labelText: "Location",
                          hintText: "e.g. where the workshop takes place"),
                    ),
                    const SizedBox(height: 20),
                    DateTimeField(
                      onChanged: (value) {
                        setState(() {
                          dateController.text = value.toString();
                        });
                      },
                      initialValue: eventDate,
                      format: DateFormat('d MMMM y'),
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
                        labelText: "Date",
                        hintText: "When the workshop will be held",
                      ),
                    ),
                    const SizedBox(height: 20),
                    DateTimeField(
                      onChanged: (value) {
                        setState(() {
                          startTimeController.text = value.toString();
                        });
                      },
                      initialValue: eventStartTime,
                      format: DateFormat.Hm(),
                      onShowPicker: (context, currentValue) async {
                        final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()));
                        return DateTimeField.convert(time);
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          labelText: "Start Time",
                          hintText: "e.g. when the workshop will be start"),
                    ),
                    const SizedBox(height: 20),
                    DateTimeField(
                      onChanged: (value) {
                        setState(() {
                          endTimeController.text = value.toString();
                        });
                      },
                      initialValue: eventEndTime,
                      format: DateFormat.Hm(),
                      onShowPicker: (context, currentValue) async {
                        final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()));
                        return DateTimeField.convert(time);
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          labelText: "End Time",
                          hintText: "e.g. when the workshop will be finished"),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: BrandColor.colorPrimary,
                            minimumSize: const Size.fromHeight(50)),
                        onPressed: () {
                          try {
                            workshop.doc(widget.id).update({
                              'notes': notesController.text,
                              'location': locationController.text,
                              'date': (dateController.text == '')
                                  ? widget.date.toString()
                                  : dateController.text,
                              'start_time': (startTimeController.text == '')
                                  ? widget.start_time.toString()
                                  : startTimeController.text,
                              'end_time': (endTimeController.text == '')
                                  ? widget.end_time
                                  : endTimeController.text,
                            });

                            Navigator.pop(context);
                          } catch (e) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text('Insert Result'),
                                      content: const Text(
                                          "Failed to add new member"),
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
                        child: const Text("UPDATE")),
                    // SizedBox(
                    //   child: ElevatedButton(
                    //     child: Text(notesController.text),
                    //     onPressed: () {
                    //       print(dateController.text == '');
                    //     },
                    //   ),
                    // )
                  ],
                ),
              ),
            )));
  }
}
