import 'package:bitcoin_tracker/Data/coin_data.dart';
import 'package:bitcoin_tracker/Presentation/Widgets/exchangeCard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  int choice = 19;
  String start_val = currenciesList[19];
  CoinData coinData = CoinData();
  String BTCexchangeRate = "?";
  String ETHexchangeRate = "?";
  String LTCexchangeRate = "?";
  late bool isFetching;

  @override
  void initState() {
    super.initState();
    initRates();
  }

  initRates([String? curr]) async {
    setState(() {
      isFetching = true;
    });
    var BTC = await coinData.setRate(
      cryp: "BTC",
      cur: curr ?? "USD",
    );
    var ETh = await coinData.setRate(
      cryp: "ETH",
      cur: curr ?? "USD",
    );
    var LTC = await coinData.setRate(
      cryp: "LTC",
      cur: curr ?? "USD",
    );
    setState(() {
      isFetching = false;
      BTCexchangeRate = BTC;
      ETHexchangeRate = ETh;
      LTCexchangeRate = LTC;
    });
  }

  Widget IosPicker() {
    return CupertinoPicker(
      itemExtent: 32,
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (index) {
        if (kDebugMode) {
          print(index);
        }
        initRates(currenciesList[choice]);
        setState(() {
          choice = index;
        });
      },
      children: currenciesList
          .map(
            (e) => Text(e),
          )
          .toList(),
    );
  }

  DropdownButton<String> AndroidDropMenu() {
    return DropdownButton(
      value: start_val,
      items: currenciesList
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          start_val = value!;
          initRates(start_val);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: ExchangeCard(
              choice: choice,
              start_val: start_val,
              crypt: 'BTC',
              exchangeRate: BTCexchangeRate,
              isLoading: isFetching,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: ExchangeCard(
              choice: choice,
              start_val: start_val,
              crypt: 'ETH',
              exchangeRate: ETHexchangeRate,
              isLoading: isFetching,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 18.0),
            child: ExchangeCard(
              choice: choice,
              start_val: start_val,
              crypt: 'LTC',
              exchangeRate: LTCexchangeRate,
              isLoading: isFetching,
            ),
          ),
          Expanded(child: Container()),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            //TODO : change isAndroid to isIos
            child: Platform.isIOS ? IosPicker() : AndroidDropMenu(),
          ),
        ],
      ),
    );
  }
}
