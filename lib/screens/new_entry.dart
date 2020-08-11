import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import 'package:track_seizure/component/database/db.dart';
import 'package:track_seizure/component/seizure_data.dart';
import 'package:track_seizure/component/header.dart';
import 'package:track_seizure/component/constants.dart';
import 'package:track_seizure/component/entryComponents.dart';


class NewEntryPage extends StatefulWidget {
  Seizure seizeEntry;
  NewEntryPage({this.seizeEntry});

  @override
  _NewEntryPageState createState() => _NewEntryPageState(seizeEntry: seizeEntry);
}

class _NewEntryPageState extends State<NewEntryPage> {
  Seizure seizeEntry;
  _NewEntryPageState({this.seizeEntry});


  TextEditingController nameController = TextEditingController();
  String selectedType = "";
  int length = 60;
  int feel = 5;
  String note = "";
  String dateTime = (DateFormat('dd-MM-yy – kk:mm').format(DateTime.now()));
  String status = "new";
  @override
  void initState() {
    if (seizeEntry != null){
      status = "edit"; 
      dateTime = seizeEntry.date;
      feel = seizeEntry.feel; 
      note = seizeEntry.note; 
      length = seizeEntry.length;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EntryHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Time:',
                        style: trackHeaderStyle,
                      ),
                      FlatButton(
                        onPressed: () {
                          if (status=="new"){
                            DatePicker.showDateTimePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2018, 3, 5),
                              maxTime: DateTime.now(), 
                              onConfirm: (date) {
                                setState(() {
                                  dateTime = (DateFormat('dd-MM-yy – kk:mm').format(date)).toString();
                                });
                                print(dateTime);
                              }, 
                              currentTime: DateTime.now(), 
                              locale: LocaleType.en
                              );
                          }
                          },
                        child: Text(dateTime, style: kEntryDate),
                        ),
                    ],
                  ),
                  Text(
                    'Which type of seizure ?',
                    style: trackHeaderStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EntryOption(
                        colour: kAbsenceColor,
                        text: 'Absence',
                        icon: FontAwesome.eye,
                        onPress: () {
                          setState(() {
                            selectedType = "Absence";
                          });
                        },
                        textstyle: selectedType == "Absence"
                            ? kNewEntryTextStyleActive
                            : kNewEntryTextStyleInactive,
                      ),
                      EntryOption(
                        colour: kGeneralizedColor,
                        text: 'Generalized',
                        icon: FontAwesome.male,
                        onPress: () {
                          setState(() {
                            selectedType = "Generalized";
                          });
                        },
                        textstyle: selectedType == "Generalized"
                            ? kNewEntryTextStyleActive
                            : kNewEntryTextStyleInactive,
                      ),
                      EntryOption(
                        colour: kOtherColor,
                        text: 'Other',
                        icon: FontAwesome.question,
                        onPress: () {
                          setState(() {
                            selectedType = "Other";
                          });
                        },
                        textstyle: selectedType == "Other"
                            ? kNewEntryTextStyleActive
                            : kNewEntryTextStyleInactive,
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    'Length : $length sec',
                    style: trackHeaderStyle,
                  ),
                  SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: Color(0xFFd9d9d9),
                        activeTrackColor: kBottomGradientColor,
                        thumbColor: kBottomGradientColor,
                        overlayColor: Color(0x295126AB),
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                      ),
                      child: Slider(
                          value: length.toDouble(),
                          min: 10.0,
                          max: 120.0,
                          onChanged: (double newValue) {
                            setState(() {
                              length = newValue.round();
                            });
                          })),
                  SizedBox(height: 15.0),
                  Text(
                    'Intensity : $feel /10',
                    style: trackHeaderStyle,
                  ),
                  SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: Color(0xFFd9d9d9),
                        activeTrackColor: kBottomGradientColor,
                        thumbColor: kBottomGradientColor,
                        overlayColor: Color(0x295126AB),
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                      ),
                      child: Slider(
                          value: feel.toDouble(),
                          max: 10.0,
                          onChanged: (double newValue) {
                            setState(() {
                              feel = newValue.round();
                            });
                          })),
                  SizedBox(height: 15.0),
                  Text(
                    'Additional notes:',
                    style: trackHeaderStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      style: kInputTextStyle,
                      controller: nameController,
                      cursorColor: Colors.white,
                      decoration: noteDecoration(),
                      onChanged: (text) {
                        setState(() {
                          note = text;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: EntryButton(
                      text: 'Save',
                      onPress: () async {
                        Seizure entry = Seizure(date: dateTime,type: selectedType,length: length,feel: feel,note: note); 
                        if (status=="new"){
                          DatabaseService.db.createSeize(entry);
                        } else if (status=="edit"){
                          DatabaseService.db.updateSeize(entry);
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            
          ],
        ),
      )
    );
  }
}


