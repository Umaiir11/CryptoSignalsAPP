class CurrenciesSymbolsData {
  final List<CurrencySymbols>? currencies;

  CurrenciesSymbolsData({this.currencies});

  factory CurrenciesSymbolsData.fromJson(Map<String, dynamic> json) {
    return CurrenciesSymbolsData(
      currencies: (json['currencies'] as List<dynamic>?)
          ?.map((item) => CurrencySymbols.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currencies': currencies?.map((CurrencySymbols) => CurrencySymbols.toJson()).toList(),
    };
  }
}

class CurrencySymbols {
  final int? id;
  final String? symbol;

  CurrencySymbols({this.id, this.symbol});

  factory CurrencySymbols.fromJson(Map<String, dynamic> json) {
    return CurrencySymbols(
      id: json['id'] as int?,
      symbol: json['symbol'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CurrencySymbols) return false;
    return id == other.id && symbol == other.symbol;
  }

  @override
  int get hashCode => Object.hash(id, symbol);
}
