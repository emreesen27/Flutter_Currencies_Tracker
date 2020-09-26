import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/conversion_model.dart';
import 'models/currency_model.dart';
import 'models/time_series_model.dart';

class Currency {
  static Future<ConversionModel> getConversion({
    @required String from,
    @required String to,
    @required String amount,
  }) async {
    var _response = await http.get(
        'https://api.frankfurter.app/latest?amount=$amount&from=$from&to=$to');
    if (_response.statusCode == 200 && _response.body.isNotEmpty) {
      var _data = CurrencyModel.fromJson(json.decode(_response.body));
      return ConversionModel(
          date: _data.date, rate: _data.rates.values.elementAt(0));
    } else
      return throw ('statusCode: ${_response.statusCode}');
  }

  static Future<CurrencyModel> getLatest({@required String from}) async {
    var _response =
        await http.get('https://api.frankfurter.app/latest?from=$from');
    if (_response.statusCode == 200 && _response.body.isNotEmpty)
      return CurrencyModel.fromJson(json.decode(_response.body));
    else
      throw ('statusCode: ${_response.statusCode}');
  }

  static Future<Map<String, dynamic>> getCurrencies() async {
    var _response = await http.get('https://api.frankfurter.app/currencies');
    if (_response.statusCode == 200 && _response.body.isNotEmpty)
      return json.decode(_response.body);
    else
      throw ('statusCode: ${_response.statusCode}');
  }

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
          rates: _rates, dates: _dates, dateAndRates: _data.rates);
    } else
      return throw ('statusCode: ${_response.statusCode}');
  }
}
