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
  'XRP',
];

const coinApiUrl = 'https://rest.coinapi.io/v1/exchangerate';
const coinApiKey = 'BE3300AD-2960-4815-AEA9-F2F33A4F0010';

class CoinData {
  Future<Map> getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestUrl =
          '$coinApiUrl/$crypto/$selectedCurrency?apikey=$coinApiKey';
      http.Response response = await http.get(requestUrl);

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        cryptoPrices[crypto] = jsonResponse['rate'].toStringAsFixed(2);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    print(cryptoPrices);
    return cryptoPrices;
  }
}
