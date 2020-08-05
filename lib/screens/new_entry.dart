import 'package:flutter/material.dart';
import 'package:track_seizure/component/constants.dart';
import 'package:track_seizure/component/entryComponents.dart';
import 'package:flutter_icons/flutter_icons.dart';

enum Type { absence, tc, other }

class NewEntryPage extends StatefulWidget {
  NewEntryPage({Key key}) : super(key: key);

  @override
  _NewEntryPageState createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  TextEditingController nameController = TextEditingController();
  Type selectedType;
  int lenght = 60;
  int feel = 5;
  String note = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: 40.0),
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
              'Lenght : $lenght sec',
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
                    value: lenght.toDouble(),
                    min: 10.0,
                    max: 120.0,
                    onChanged: (double newValue) {
                      setState(() {
                        lenght = newValue.round();
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
            SizedBox(height: 20,),
            EntryButton(
              text: 'Save',
              onPress: () {
                Navigator.pop(context);
              },
            ),
          ],
        ));
  }
}