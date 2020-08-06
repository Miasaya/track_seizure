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
          height: 450.0,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
                kBottomGradientColor,
                kTopGradientColor,
              ])),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Text('Track. Analyse. Break Free.', style : kHeaderTextStyle),
                  ),   
                  Positioned(
                    top: 80,
                    child: Image.asset(
                      'assets/images/doctor.png',
                      width: 330,
                      fit: BoxFit.fitWidth,
                    ),
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
        size.width / 2, size.height, size.width, size.height - 90);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}


class EntryHeader extends StatelessWidget {
  const EntryHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
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

class LogHeader extends StatelessWidget {
  const LogHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: LogTrackClipper(),
      child: Container(
          width: double.infinity,
          height: 120.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
              kBottomGradientColor,
              kTopGradientColor,
            ]),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text('Recent Entries', style : kHeaderTextStyle),
                  ),   
                ],
              )),
            ],
          )),
    );
  }
}

class LogTrackClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 90);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}