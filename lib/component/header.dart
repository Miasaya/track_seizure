import 'package:flutter/material.dart';
import 'constants.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TrackClipper(),
      child: Container(
          width: double.infinity,
          height: 320.0,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
                Color(0xFF554BD8),
                Color(0xFF804CD9),
              ])),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Stack(
                children: <Widget>[
                  Positioned(
                    left : 150,
                    child: Image.asset(
                      'assets/images/doctor.png',
                      width: 280,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left :20,
                    child: Text('Track.', style : kHeaderTextStyle),
                  ),
                  Positioned(
                    top: 130,
                    left :20,
                    child: Text('Analyse.', style : kHeaderTextStyle),
                  ),
                  Positioned(
                    top: 160,
                    left :20,
                    child: Text('Break Free.', style : kHeaderTextStyle),
                  ),                     
                ],
              )),
            ],
          )),
    );
  }
}

class TrackClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
