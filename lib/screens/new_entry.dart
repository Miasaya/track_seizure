import 'package:flutter/material.dart';
import 'package:track_seizure/component/constants.dart';


enum Type {
  absence, 
  tc, 
  other
}

enum Feeling {
  pls, 
  sore,
  fine,
}

class NewEntryPage extends StatefulWidget {
  NewEntryPage({Key key}) : super(key: key);

  @override
  _NewEntryPageState createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  Type selectedType; 
  double lenght = 1.0; 
  Feeling feel; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
                child: Row(
                  children: [
                    EntryOption(
                      colour: Colors.orange[300],
                      text: 'Absence',
                      onPress: () {
                        setState(() {
                        selectedType = Type.absence;
                      });},
                      textstyle: selectedType == Type.absence
                      ? kNewEntryTextStyleActive
                      : kNewEntryTextStyleInactive,
                    ),
                    EntryOption(
                      colour: Colors.red[400],
                      text: 'Generalized',
                      onPress: () {
                        setState(() {
                        selectedType = Type.tc;
                      });},
                      textstyle: selectedType == Type.tc
                      ? kNewEntryTextStyleActive
                      : kNewEntryTextStyleInactive,
                    ),
                    EntryOption(
                      colour: Colors.green[400],
                      text: 'Other',
                      onPress: () {
                        setState(() {
                        selectedType = Type.other;
                      });},
                      textstyle: selectedType == Type.other
                      ? kNewEntryTextStyleActive
                      : kNewEntryTextStyleInactive,
                    ),
              ],
            ))
          ],
        ));
  }
}

class EntryOption extends StatelessWidget {
  EntryOption({@required this.colour, this.text, this.onPress, this.textstyle});

  final Color colour;
  final String text;
  final Function onPress;
  final TextStyle textstyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 100.0,
        height: 100.0,
        child: Text(text, style : textstyle),
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
    ),
                  ),
                );
  }
}
