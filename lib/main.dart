import 'dart:io';

import 'package:flutter/material.dart';
import 'package:urban_culture_daily_skincare/screens/daily_skincare_page.dart';
import 'package:urban_culture_daily_skincare/screens/upload_file.dart';
void main() {
  runApp( SkincareApp());
}

class SkincareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SkincareRoutinePage(),
    );
  }
}



