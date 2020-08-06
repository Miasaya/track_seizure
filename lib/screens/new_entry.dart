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
  NewEntryPage({Key key}) : super(key: key);

  @override
  _NewEntryPageState createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  DatabaseService dbService = DatabaseService();
  TextEditingController nameController = TextEditingController();
  Type selectedType;
  int length = 60;
  int feel = 5;
  String note = "";
  String date_time = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              EntryHeader(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Time: ',
                    style: trackHeaderStyle,
                  ),
                  FlatButton(
                    onPressed: () {
                      DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2018, 3, 5),
                        maxTime: DateTime.now(), 
                        onConfirm: (date) {
                          setState(() {
                            date_time = (DateFormat('yyyy-MM-dd – kk:mm').format(date)).toString();
                          });
                          print(date_time);
                        }, 
                        currentTime: DateTime.now(), 
                        locale: LocaleType.en
                        );
                      },
                    child: Text(date_time, style: kEntryDate,),
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
                    colour: Colors.orange[300],
                    text: 'Absence',
                    icon: FontAwesome.eye,
                    onPress: () {
                      setState(() {
                        selectedType = Type.absence;
                      });
                      print(selectedType);
                    },
                    textstyle: selectedType == Type.absence
                        ? kNewEntryTextStyleActive
                        : kNewEntryTextStyleInactive,
                  ),
                  EntryOption(
                    colour: Colors.red[400],
                    text: 'Generalized',
                    icon: FontAwesome.male,
                    onPress: () {
                      setState(() {
                        selectedType = Type.tc;
                      });
                      print(selectedType);
                    },
                    textstyle: selectedType == Type.tc
                        ? kNewEntryTextStyleActive
                        : kNewEntryTextStyleInactive,
                  ),
                  EntryOption(
                    colour: Colors.green[400],
                    text: 'Other',
                    icon: FontAwesome.question,
                    onPress: () {
                      setState(() {
                        selectedType = Type.other;
                      });
                      print(selectedType);
                    },
                    textstyle: selectedType == Type.other
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
                height: 20,
              ),
              EntryButton(
                text: 'Save',
                onPress: () {
                  print(DateTime.now().toString());
                  Seizure entry = Seizure(date: DateTime.now(),type: selectedType,length: length,feel: feel,note: note); 
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ));
  }
}


