# Flutter Currencies Tracker

A Flutter library where you can keep track of current exchange rates.

pub.dev = https://pub.dev/packages/flutter_currencies_tracker;

## Getting Started

You must add the library as a dependency to your project.
```yaml
dependencies:
 flutter_currencies_tracker: ^0.0.3
```

You should then run `flutter packages get`

Now in your Dart code, you can use:

```dart
import 'package:flutter_currencies_tracker/flutter_currencies_tracker.dart'
```

## Usage Example

 This method returns the latest rates.You have to set the currency you want to the 'from' parameter.
```dart
var result = await Currency.getLatest(from: 'USD');
    String date = result.date; // Returns the last updated date  eg: 2020-09-25  Type: String 
    List rates = result.rates; // Returns the results  eg: [1.4224, 1.6811, 5.5493, ... ]  Type: List
    List symbol = result.symbol; // Returns currency symbols eg: [AUD, BGN, BRL, ... ]
    Map fullData = result.symbolAndRates; // Returns the results in Map eg: {AUD: 1.4224, BGN: 1.6811, BRL: 5.5493, ... }
```
You can convert to currencies using the amount parameter.
```dart
var result = await Currency.getConversion(from: 'USD', to: 'TRY', amount: '1');
    String date = result.date; // Returns the last updated date
    double rate = result.rate; // Returns the result in double.
```
 This method returns historical rates for any working day since 4 January 1999.
```dart
var result = await Currency.getHistorical(from: 'USD', date: '2018-10-24');
    String date = result.date;
    List rates = result.rates;
    List symbol = result.symbol;
    Map fullData = result.symbolAndRates;
```
 This method returns a set of historical rates for a given time period.
```dart
var result = await Currency.getTimeSeries(
    startDate: '2020-02-08',
    endDate: '2020-05-05',
    from: 'USD',
    to: 'AUD');
    
List rates = result.rates; // returns rates in List
List dates = result.dates; // returns the date range eg: [2020-02-10, 2020-02-11, ... ] Type: List
Map fullData = result.dateAndRates; // returns full data eg: {2020-02-10: {AUD: 1.4951}, 2020-02-11: {AUD: 1.4916}, .. } Type: Map
```
This method gets a list of available currency symbols along with their full names.
```dart
var result = await Currency.getCurrencies();
// result is a map eg: {AUD: Australian Dollar, BGN: Bulgarian Lev, .. }
```
Full Currencies List
```json
{
    "AUD": "Australian Dollar",
    "BGN": "Bulgarian Lev",
    "BRL": "Brazilian Real",
    "CAD": "Canadian Dollar",
    "CHF": "Swiss Franc",
    "CNY": "Chinese Renminbi Yuan",
    "CZK": "Czech Koruna",
    "DKK": "Danish Krone",
    "EUR": "Euro",
    "GBP": "British Pound",
    "HKD": "Hong Kong Dollar",
    "HRK": "Croatian Kuna",
    "HUF": "Hungarian Forint",
    "IDR": "Indonesian Rupiah",
    "ILS": "Israeli New Sheqel",
    "INR": "Indian Rupee",
    "ISK": "Icelandic Króna",
    "JPY": "Japanese Yen",
    "KRW": "South Korean Won",
    "MXN": "Mexican Peso",
    "MYR": "Malaysian Ringgit",
    "NOK": "Norwegian Krone",
    "NZD": "New Zealand Dollar",
    "PHP": "Philippine Peso",
    "PLN": "Polish Złoty",
    "RON": "Romanian Leu",
    "RUB": "Russian Ruble",
    "SEK": "Swedish Krona",
    "SGD": "Singapore Dollar",
    "THB": "Thai Baht",
    "TRY": "Turkish Lira",
    "USD": "United States Dollar",
    "ZAR": "South African Rand"
}
```
## Example App
<img src = "https://github.com/emreesen27/Flutter_Currencies_Tracker/blob/assets/example.gif?raw=true">

