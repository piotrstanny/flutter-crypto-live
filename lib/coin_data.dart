import 'dart:convert';
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

const coinApiUrl = 'https://rest.coinapi.io/v1/exchangerate/BTC/USD';
const coinApiKey = 'BE3300AD-2960-4815-AEA9-F2F33A4F0010';

class CoinData {
  Future getCoinData() async {
    http.Response response = await http.get('$coinApiUrl?apikey=$coinApiKey');

    if (response.statusCode == 200) {
      String data = response.body;
      print(response.statusCode);
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
