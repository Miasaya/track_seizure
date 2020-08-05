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
