import 'dart:io' show Platform;

import 'package:bitcoin_tracker/Data/coin_data.dart';
import 'package:flutter/material.dart';

class ExchangeCard extends StatelessWidget {
   ExchangeCard({super.key,required this .crypt, required this.choice, required this.start_val, required this.exchangeRate, required this.isLoading});

  int choice;
  String start_val;
  String crypt;
  String exchangeRate;
  bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          Platform.isIOS?"1 $crypt = ${isLoading ? "?": exchangeRate} ${currenciesList[choice]}" : "1 $crypt = ${isLoading ? "?": exchangeRate} $start_val",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
