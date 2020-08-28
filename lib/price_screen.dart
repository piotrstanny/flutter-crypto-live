import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[0];
  String price = '?';
  String coin = 'BTC';

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
            getPrice();
          });
        });
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      Text item = Text(currency);
      pickerItems.add(item);
    }

    return CupertinoPicker(
      backgroundColor: Color(0xFFf9a825),
      itemExtent: 30.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getPrice();
        });
      },
      children: pickerItems,
    );
  }

  void getPrice() async {
    try {
      String temp = await CoinData().getCoinData(selectedCurrency, 'ETH');
      setState(() {
        price = temp;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getPrice();
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
          CryptoCard(
            selectedCoin: coin,
            price: price,
            selectedCurrency: selectedCurrency,
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

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    @required this.price,
    @required this.selectedCurrency,
    @required this.selectedCoin,
  });

  final String price;
  final String selectedCurrency;
  final String selectedCoin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Color(0xFF607D8B),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $selectedCoin = $price $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
