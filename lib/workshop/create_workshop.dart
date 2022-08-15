import 'package:archery_club/constant/brand_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateWorkshop extends StatefulWidget {
  const CreateWorkshop({Key? key}) : super(key: key);

  @override
  State<CreateWorkshop> createState() => _CreateWorkshopState();
}

class _CreateWorkshopState extends State<CreateWorkshop> {
  TextEditingController notesController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference workshops = firestore.collection('workshops');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: BrandColor.colorPrimary,
          title: const Text('Add Workshop Schedule'),
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
                      controller: notesController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          labelText: "Notes",
                          hintText: "e.g. workshop name"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: locationController,
                      onChanged: (value) {
                        setState(() {});
                      },
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
                        // setState(() {
                        //   if ( value != null ) {
                        //     String dateTime =
                        //       DateFormat.yMMMMd('en_US').format(value);
                        //     dateController.text = dateTime;
                        //   } else {
                        //     dateController.text = '';
                        //   }

                        // });
                      },
                      // format: DateFormat.yMMMMd('en_US'),
                      format: DateFormat("d MMMM y"),
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
                          // String startTime =
                          //     DateFormat("dd-MM-yyyy").format(value!);
                          startTimeController.text = value.toString();
                        });
                      },
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
                          endTimeController.text = value.toString();
                        });
                      },
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
                            workshops.add({
                              'notes': notesController.text,
                              'location': locationController.text,
                              'date': dateController.text,
                              'start_time': startTimeController.text,
                              'end_time': endTimeController.text,
                            });

                            notesController.text = '';
                            locationController.text = '';
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
                                          "Failed to add new workshop"),
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
                  ],
                ),
              ),
            )));
  }

  @override
  void dispose() {
    notesController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }
}
