import 'package:flutter/material.dart';
import 'package:flutter_currencies_tracker/flutter_currencies_tracker.dart';

void main() {
  runApp(MyExample());
}

class MyExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  getData() async {
    var responseCurrency =
        await Currency.getConversion(from: 'AUD', to: 'USD', amount: '1');
    //print(responseCurrency.date);
    //print(responseCurrency.rate);

    var responseLatest = await Currency.getLatest(from: 'USD');
    //print(responseLatest.date);
    //print(responseLatest.rates);

    var responseCurrencies = await Currency.getCurrencies();
     //print(responseCurrencies);

    var responseTimeLine = await Currency.getTimeSeries(
      startDate: '2020-01-01',
      endDate: '2020-01-20',
      from: 'USD',
      to: 'TRY',
    );

    //print(responseTimeLine.rates);
    //print(responseTimeLine.date);
    //print(responseTimeLine.dates);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('asdasd'),
        ),
      ),
    );
  }
}
