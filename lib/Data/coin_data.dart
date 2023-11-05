import 'dart:convert';

import 'package:bitcoin_tracker/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData({required String crypto, required String currency}) async {
    Uri url = Uri.parse("https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$kCoinAPIkey");
    http.Response response =  await http.get(url);
    if (response.statusCode == 200)
      {
        var data = jsonDecode(response.body);
        print(data);
        return (data["rate"]);
      }else {
      debugPrint(response.statusCode.toString());
      return (null);
    }
  }
  Future<String> setRate({required String cryp, required String cur}) async{
    double rate =   await getCoinData(crypto: cryp,currency: cur);
    return (rate.toStringAsFixed(0));
  }

  }

