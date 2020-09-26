class CurrencyModel {
	CurrencyModel();

	String date;
	Map<String, dynamic> rates;

	factory CurrencyModel.fromJson(Map<String, dynamic> json) =>
			currencyFromJson(json);
}

currencyFromJson(Map<String, dynamic> json) {
	return CurrencyModel()
		..date = json['date'] as String
		..rates = json['rates'] as Map<String, dynamic>;
}


