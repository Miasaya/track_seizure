import 'package:flutter/material.dart';
import 'constants.dart';

class EntryButton extends StatelessWidget {
  EntryButton({@required this.text, this.onPress});

  final String text;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: RaisedButton(
        onPressed: onPress,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  kBottomGradientColor,
                  kTopGradientColor,
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: kTrackingButton,
            ),
          ),
        ),
      ),
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
        width: 90.0,
        height: 80.0,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
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

InputDecoration noteDecoration() {
  return InputDecoration(
    filled: true,
    fillColor: Color(0xF06a52cc),
    hintText: 'Anything Else?',
    hintStyle: kInputTextStyle,
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.grey[100])),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.grey[100])),
  );
}



