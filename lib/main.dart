import 'package:calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(MyApp());
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"달력",
      debugShowCheckedModeBanner: false,
      home: Calendar(),
    );
  }
}
