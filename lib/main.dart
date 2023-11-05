import 'package:bitcoin_tracker/Presentation/price_screen.dart';
import 'package:bitcoin_tracker/constants.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white),
      home: PriceScreen(),
    );
  }
}