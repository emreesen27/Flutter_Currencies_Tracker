# example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_currencies_tracker/flutter_currencies_tracker.dart';

void main() {
  runApp(MyExample());
}

class MyExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _updateDate;
  List _symbol;
  List _rates;
  bool _isLoading = false;
  Map currenciesMap;

  /// If you want to use the map, remove the comment line
  // Map _fullData;

  getData() async {
    currenciesMap = await Currency.getCurrencies();
    var responseLatest = await Currency.getLatest(from: 'USD');
    setState(() {
      _updateDate = responseLatest.date;
      _symbol = responseLatest.symbol;
      _rates = responseLatest.rates;
      _isLoading = true;

      /// If you want to use the map, remove the comment line
      // _fullData = responseLatest.symbolAndRates;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isLoading == false
              ? 'Last Update:'
              : 'Base: USD Last Update: $_updateDate',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: _isLoading == true
              ? ListView.builder(
                  itemCount: _rates.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.monetization_on),

                        /// If you want to use the map
                        // _fullData.keys.elementAt(index) returns symbol
                        title:
                            Text('${currenciesMap[_symbol.elementAt(index)]}'),
                        // _fullData.value.elementAt(index) returns rates
                        subtitle: Text('${_rates.elementAt(index)}'),
                      ),
                    );
                  },
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
```
