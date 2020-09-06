import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'crypto_card.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[0];
  String price = '?';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (int i = 0; i < currenciesList.length; i++) {
      DropdownMenuItem<String> item = DropdownMenuItem(
        child: Text(currenciesList[i]),
        value: currenciesList[i],
      );
      dropdownItems.add(item);
    }

    return DropdownButton(
        value: selectedCurrency,
        iconSize: 40,
        items: dropdownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            getPrices();
          });
        });
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      Text item = Text(
        currency,
        style: TextStyle(color: Colors.white),
      );
      pickerItems.add(item);
    }

    return CupertinoPicker(
      backgroundColor: Colors.grey[800],
      itemExtent: 30.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getPrices();
        });
      },
      children: pickerItems,
    );
  }

  Map<String, String> coinValues = {};
  bool isWaiting = false;

  void getPrices() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  List<Widget> getCryptoList() {
    List<CryptoCard> cryptoCards = [];

    for (String crypto in cryptoList) {
      cryptoCards.add(CryptoCard(
        selectedCoin: crypto,
        price: isWaiting ? '?' : coinValues[crypto],
        selectedCurrency: selectedCurrency,
      ));
    }
    return cryptoCards;
  }

  @override
  void initState() {
    super.initState();
    getPrices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CRYPTO LIVE PRICES',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: getCryptoList(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Color(0xFF212121),
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
