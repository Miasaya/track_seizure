import 'package:flutter/material.dart';
import 'package:track_seizure/component/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';

enum Type { absence, tc, other }

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
            Text('Which type of seizure ?',style: trackHeaderStyle,),
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
            
          ],
        )
      );
  }
}

class EntryOption extends StatelessWidget {
  EntryOption(
      {@required this.colour,
      this.text,
      this.icon,
      this.onPress,
      this.textstyle});

  final Color colour;
  final String text;
  final Function onPress;
  final TextStyle textstyle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 100.0,
        height: 80.0,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 40.0,
              ),
            ),
            Text(text, style: textstyle),
          ],
        ),
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
