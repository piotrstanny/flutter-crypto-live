import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'USD',
  'EUR',
  'GBP',
  'PLN',
  'AUD',
  'BRL',
  'CAD',
  'IDR',
  'INR',
  'JPY',
  'MXN',
  'NZD',
  'RUB',
  'SGD',
  'ZAR',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinApiUrl = 'https://rest.coinapi.io/v1/exchangerate';
const coinApiKey = 'BE3300AD-2960-4815-AEA9-F2F33A4F0010';

String coinName;
String coinPrice;

class CoinData {
  Future<String> getCoinData(String selectedCurrency) async {
    http.Response response =
        await http.get('$coinApiUrl/ETH/$selectedCurrency?apikey=$coinApiKey');

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(response.statusCode);
      print(jsonResponse);
      coinName = jsonResponse['asset_id_base'];
      coinPrice = jsonResponse['rate'].toStringAsFixed(2);
      return coinPrice;
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
