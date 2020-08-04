import 'package:flutter/material.dart';
import 'package:track_seizure/component/constants.dart';

class TrackingPage extends StatefulWidget {
  TrackingPage({Key key}) : super(key: key);

  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          ClipPath(
            clipper: TrackClipper(),
            child: Container(
              width: double.infinity,
              height: 350.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end : Alignment.topLeft, 
                  colors: [
                    Color(0xFF554BD8),
                    Color(0xFF804CD9),
                  ]
                )
              ),
            ),
          ),
          Center(
            child: Text(
              'Anything up today?',
              style: trackHeaderStyle,
            ),
          )
        ],
      );
  }
}

class TrackClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, 
  size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }
  @override 
  bool shouldReclip(CustomClipper<Path> oldClipper){
    return false;
  }
}