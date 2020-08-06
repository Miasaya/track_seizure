import 'package:flutter/material.dart';
import 'package:track_seizure/component/constants.dart';
import 'package:track_seizure/component/entryComponents.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:track_seizure/component/seizure_data.dart'; 


class NewEntryPage extends StatefulWidget {
  NewEntryPage({Key key}) : super(key: key);

  @override
  _NewEntryPageState createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  TextEditingController nameController = TextEditingController();
  Type selectedType;
  int length = 60;
  int feel = 5;
  String note = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                  clipper: ClipperEntry(),
                  child: Container(
                    width: double.infinity,
                    height: 200.0,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: [
                          kBottomGradientColor,
                          kTopGradientColor,
                        ])),
                    child: Image.asset(
                      'assets/images/stay.png',
                      width: 100,
                    ),
                  )),
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
                'length : $length sec',
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
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ));
  }
}

class ClipperEntry extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
