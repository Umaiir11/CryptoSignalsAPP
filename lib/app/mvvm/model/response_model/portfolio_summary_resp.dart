class PortfolioSummaryResponse {
  final double? initialPortfolioTotal;
  final double? currentPortfolioTotal;
  final double? profitPercentage;
  final double? lossPercentage;
  final Map<String, double>? coinPercentages;
  final FearGreed? fearGreed;

  PortfolioSummaryResponse({
    this.initialPortfolioTotal,
    this.currentPortfolioTotal,
    this.profitPercentage,
    this.lossPercentage,
    this.coinPercentages,
    this.fearGreed,
  });

  factory PortfolioSummaryResponse.fromJson(Map<String, dynamic> json) {
    return PortfolioSummaryResponse(
      initialPortfolioTotal: _parseDouble(json['initial_portfolio_total']),
      currentPortfolioTotal: _parseDouble(json['current_portfolio_total']),
      profitPercentage: _parseDouble(json['profit_percentage']),
      lossPercentage: _parseDouble(json['loss_percentage']),
      coinPercentages: _parseCoinPercentages(json['coin_percentages']),
      fearGreed: json['feargreed'] != null
          ? FearGreed.fromJson(json['feargreed'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'initial_portfolio_total': initialPortfolioTotal,
      'current_portfolio_total': currentPortfolioTotal,
      'profit_percentage': profitPercentage,
      'loss_percentage': lossPercentage,
      'coin_percentages': coinPercentages,
      'feargreed': fearGreed?.toJson(),
    };
  }

  // Static method for parsing double values
  static double? _parseDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }

  // Method to handle the coin_percentages field, accounting for both Map and List cases
  static Map<String, double>? _parseCoinPercentages(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value.map((key, value) => MapEntry(key, _parseDouble(value) ?? 0.0));
    } else if (value is List) {
      // Handle the empty list case
      if (value.isEmpty) {
        return {};
      }
    }
    return null;
  }
}





class FearGreed {
  final int? id;
  final double? percentage;

  FearGreed({
    this.id,
    this.percentage,
  });

  factory FearGreed.fromJson(Map<String, dynamic> json) {
    return FearGreed(
      id: json['id'] as int?,
      percentage: (json['percentage'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'percentage': percentage,
    };
  }
}
