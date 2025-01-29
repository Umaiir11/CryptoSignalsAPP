import 'package:souq_ai/app/mvvm/model/response_model/user_model.dart';

import 'crypto_currenices_resp_model.dart';

class PortfolioData {
  final List<Portfolio>? portfolios;
  final double? initialPortfolioTotal;
  final double? currentPortfolioTotal;
  final double? profitPercentage;
  final double? lossPercentage;
  final Map<String, double>? coinPercentages;

  PortfolioData({
    this.portfolios,
    this.initialPortfolioTotal,
    this.currentPortfolioTotal,
    this.profitPercentage,
    this.lossPercentage,
    this.coinPercentages,
  });

  factory PortfolioData.fromJson(Map<String, dynamic> json) {
    return PortfolioData(
      portfolios: (json['portfolios'] as List?)
          ?.map((item) => Portfolio.fromJson(item as Map<String, dynamic>))
          .toList(),
      initialPortfolioTotal: _parseDouble(json['initial_portfolio_total']),
      currentPortfolioTotal: _parseDouble(json['current_portfolio_total']),
      profitPercentage: _parseDouble(json['profit_percentage']),
      lossPercentage: _parseDouble(json['loss_percentage']),
      coinPercentages: _parseCoinPercentages(json['coin_percentages']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'portfolios': portfolios?.map((e) => e.toJson()).toList(),
      'initial_portfolio_total': initialPortfolioTotal,
      'current_portfolio_total': currentPortfolioTotal,
      'profit_percentage': profitPercentage,
      'loss_percentage': lossPercentage,
      'coin_percentages': coinPercentages,
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
      // If it's an empty list, return an empty map
      if (value.isEmpty) {
        return {};
      }
      // If it's a non-empty list, handle it as needed (or return null)
    }
    return null;  // If it's neither a Map nor an empty List, return null
  }
}

class Portfolio {
  final int? id;
  final int? userId;
  final int? currencyId;
  final double? amount;
  final double? initialPrice;
  final double? currentPrice;
  final Currency? currency;
  final User? user;

  Portfolio({
    this.id,
    this.userId,
    this.currencyId,
    this.amount,
    this.initialPrice,
    this.currentPrice,
    this.currency,
    this.user,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json) {
    return Portfolio(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      currencyId: json['currency_id'] as int?,
      amount: _parseDouble(json['amount']),
      initialPrice: _parseDouble(json['initial_price']),
      currentPrice: _parseDouble(json['current_price']),
      currency: json['currency'] != null
          ? Currency.fromJson(json['currency'] as Map<String, dynamic>)
          : null,
      user: json['user'] != null
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'currency_id': currencyId,
      'amount': amount,
      'initial_price': initialPrice,
      'current_price': currentPrice,
      'currency': currency?.toJson(),
      'user': user?.toJson(),
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
}
