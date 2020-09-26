import 'package:flutter/material.dart';

class TimeSeriesModel {
  List<dynamic> rates;

  List<dynamic> dates;

  Map<String, dynamic> dateAndRates;

  TimeSeriesModel(
      {@required this.rates,
      @required this.dates,
      @required this.dateAndRates});
}
