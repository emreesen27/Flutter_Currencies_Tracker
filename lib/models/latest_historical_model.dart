import 'package:flutter/material.dart';

class LatestAndHistoricalModel {
  String date;
  List<dynamic> symbol;
  List<dynamic> rates;
  Map<String, dynamic> symbolAndRates;

  LatestAndHistoricalModel({
    @required this.date,
    @required this.symbol,
    @required this.rates,
    @required this.symbolAndRates,
  });
}
