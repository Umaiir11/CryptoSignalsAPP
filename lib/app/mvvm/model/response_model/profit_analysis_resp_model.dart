class ProfitPercentagesResponse {
  final ProfitPercentages? profitPercentages;

  ProfitPercentagesResponse({this.profitPercentages});

  factory ProfitPercentagesResponse.fromJson(Map<String, dynamic> json) {
    return ProfitPercentagesResponse(
      profitPercentages: json['profit_percentages'] != null
          ? ProfitPercentages.fromJson(json['profit_percentages'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profit_percentages': profitPercentages?.toJson(),
    };
  }
}

class ProfitPercentages {
  final double? sevenDays;
  final double? fourteenDays;
  final double? thirtyDays;

  ProfitPercentages({
    this.sevenDays,
    this.fourteenDays,
    this.thirtyDays,
  });

  factory ProfitPercentages.fromJson(Map<String, dynamic> json) {
    return ProfitPercentages(
      sevenDays: _parseDouble(json['7_days']),
      fourteenDays: _parseDouble(json['14_days']),
      thirtyDays: _parseDouble(json['30_days']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '7_days': sevenDays,
      '14_days': fourteenDays,
      '30_days': thirtyDays,
    };
  }

  static double? _parseDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      final parsedValue = double.tryParse(value);
      if (parsedValue == null) {
        print("Failed to parse string to double: $value");
      }
      return parsedValue;
    }
    print("Unsupported type for parsing: $value");
    return null;
  }
}
