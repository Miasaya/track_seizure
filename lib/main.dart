import 'package:flutter/material.dart';
import 'screens/homescreen.dart';
import 'package:flutter/services.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(MyApp());
  }
