import 'package:archery_club/constant/brand_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditWorkshop extends StatefulWidget {
  // final id;
  // final String notes, date, start_time, end_time;

  // const EditWorkshop({Key? key, required this.id, required this.notes, required this.date, required this.start_time, required this.end_time}) : super(key: key);
  String? id;
  String? notes;
  String? date;
  String? start_time;
  String? end_time;

  EditWorkshop({
    required this.id,
    required this.notes,
    required this.date,
    required this.start_time,
    required this.end_time,
  });

  @override
  State<EditWorkshop> createState() => _EditWorkshopState();
}

class _EditWorkshopState extends State<EditWorkshop> {
  TextEditingController notesController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference workshop = firestore.collection('workshops');

    // TextEditingController notesController = TextEditingController();
    // TextEditingController notesController =
    //     TextEditingController(text: widget.notes);
    // TextEditingController dateController =
    //     TextEditingController(text: widget.date);
    // TextEditingController startTimeController =
    //     TextEditingController(text: widget.start_time);
    // TextEditingController endTimeController =
    //     TextEditingController(text: widget.end_time);

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
                      // onChanged: (value) {
                      //   setState(() {
                      //     notesController.text = value.toString();
                      //   });
                      // },
                      controller: notesController =
                          TextEditingController(text: widget.notes),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          labelText: "Notes",
                          hintText: "e.g. where the workshop takes place"),
                    ),
                    const SizedBox(height: 20),
                    DateTimeField(
                      onChanged: (value) {
                        setState(() {
                          dateController.text = value.toString();
                        });
                      },
                      // controller: dateController =
                      //     TextEditingController(text: widget.date),
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
                          // String startTime = DateFormat.Hm().format(value!);
                          // startTimeController.text = startTime;
                          startTimeController.text = value.toString();
                          // startTimeController =
                          //     TextEditingController(text: widget.start_time);
                        });
                      },
                      // controller: startTimeController =
                      //     TextEditingController(text: widget.start_time),
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
                          // String endTime = DateFormat.Hm().format(value!);
                          // endTimeController.text = endTime;
                          endTimeController.text = value.toString();
                          // endTimeController =
                          //     TextEditingController(text: widget.end_time);
                        });
                      },
                      // controller: endTimeController =
                      //     TextEditingController(text: widget.end_time),
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
                              'date': dateController.text,
                              'start_time': startTimeController.text,
                              'end_time': endTimeController.text,
                            });

                            // workshop.doc(id).update({
                            //   'notes': notesController.text,
                            //   'date': dateController.text,
                            //   'start_time': startTimeController.text,
                            //   'end_time': endTimeController.text,
                            // });

                            notesController.text = '';
                            dateController.text = '';
                            startTimeController.text = '';
                            endTimeController.text = '';

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
                        child: const Text("ADD WORKSHOP")),
                    SizedBox(
                      child: ElevatedButton(
                        child: Text(notesController.text),
                        onPressed: () {
                          print(widget.date);
                        },
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
