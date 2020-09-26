import 'package:flutter/material.dart';
import 'package:flutter_currencies_tracker/models/latest_historical_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/conversion_model.dart';
import 'models/currency_model.dart';
import 'models/time_series_model.dart';

class Currency {
  /// This method converts the currencies based on the given values.
  static Future<ConversionModel> getConversion({
    // Pass the unit you want to convert to the 'from' parameter.
    @required String from,
    // Pass the unit you want to convert to the 'to' parameter.
    @required String to,
    // You can convert currencies using the 'amount' parameter.
    @required String amount,
  }) async {
    var _response = await http.get(
        'https://api.frankfurter.app/latest?amount=$amount&from=$from&to=$to');
    if (_response.statusCode == 200 && _response.body.isNotEmpty) {
      var _data = CurrencyModel.fromJson(json.decode(_response.body));
      return ConversionModel(
        date: _data.date, // update date Type: String
        rate: _data.rates.values.elementAt(0), // conversion rate Type: double
      );
    } else
      return throw ('statusCode: ${_response.statusCode}');
  }

  /// This method returns the latest rates.
  static Future<LatestAndHistoricalModel> getLatest({
    @required String from,
  }) async {
    var _response =
        await http.get('https://api.frankfurter.app/latest?from=$from');
    if (_response.statusCode == 200 && _response.body.isNotEmpty) {
      var _data = CurrencyModel.fromJson(json.decode(_response.body));
      List<dynamic> _rates = List();
      List<dynamic> _symbol = List();

      _data.rates.forEach((key, value) {
        _rates.add(value);
        _symbol.add(key);
      });
      return LatestAndHistoricalModel(
        date: _data.date, // update date Type: String
        symbol: _symbol, // currencies symbol Type: List
        rates: _rates, // latest rates, Type: List
        symbolAndRates: _data.rates, // full data Type: Map
      );
    } else
      throw ('statusCode: ${_response.statusCode}');
  }

  /// This method gets a list of available currency symbols along with their full names.
  static Future<Map<String, dynamic>> getCurrencies() async {
    var _response = await http.get('https://api.frankfurter.app/currencies');
    if (_response.statusCode == 200 && _response.body.isNotEmpty)
      return json.decode(_response.body);
    else
      throw ('statusCode: ${_response.statusCode}');
  }

  /// This method returns historical rates for any working day since 4 January 1999.
  static Future<LatestAndHistoricalModel> getHistorical({
    @required String from,
    @required String date,
  }) async {
    var _response =
        await http.get('https://api.frankfurter.app/$date?from=$from');
    if (_response.statusCode == 200 && _response.body.isNotEmpty) {
      var _data = CurrencyModel.fromJson(jsonDecode(_response.body));
      List<dynamic> _rates = List();
      List<dynamic> _symbol = List();

      _data.rates.forEach((key, value) {
        _rates.add(value);
        _symbol.add(key);
      });
      return LatestAndHistoricalModel(
        date: _data.date, // indicates which date the data belongs to.
        symbol: _symbol, // currencies symbol Type: List
        rates: _rates, // historical rates, Type: List
        symbolAndRates: _data.rates, // full data Type: Map
      );
    } else
      throw ('statusCode: ${_response.statusCode}');
  }

  /// This endpoint returns a set of historical rates for a given time period.
  static Future<TimeSeriesModel> getTimeSeries({
    @required String startDate,
    @required String endDate,
    @required @required String from,
    @required String to,
  }) async {
    var _response = await http.get(
        'https://api.frankfurter.app/$startDate..$endDate?to=$to&from=$from');
    if (_response.statusCode == 200 && _response.body.isNotEmpty) {
      var _data = CurrencyModel.fromJson(json.decode(_response.body));
      List<dynamic> _rates = List();
      List<dynamic> _dates = List();
      _data.rates.forEach((key, value) {
        _rates.add(value['$to']);
        _dates.add(key);
      });
      return TimeSeriesModel(
        rates: _rates, // returns rates for the date range Type: List
        dates: _dates, // returns the date range Type : List
        dateAndRates: _data.rates, // full data Type: Map
      );
    } else
      return throw ('statusCode: ${_response.statusCode}');
  }
}
