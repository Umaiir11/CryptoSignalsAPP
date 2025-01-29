
import 'package:souq_ai/app/mvvm/model/response_model/zakatinstitutes_resp_model.dart';

class CurrenciesData {
  final List<Currency>? currencies;
  final Percentages? percentages;
  final Pagination? pagination;

  CurrenciesData({
    this.currencies,
    this.percentages,
    this.pagination,
  });

  factory CurrenciesData.fromJson(Map<String, dynamic> json) {
    return CurrenciesData(
      currencies: (json['currencies'] as List<dynamic>?)
          ?.map((e) => Currency.fromJson(e as Map<String, dynamic>))
          .toList(),
      percentages: json['percentages'] != null
          ? Percentages.fromJson(json['percentages'] as Map<String, dynamic>)
          : null,
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currencies': currencies?.map((e) => e.toJson()).toList(),
      'percentages': percentages?.toJson(),
      'pagination': pagination?.toJson(),
    };
  }
}

class Currency {
  final int? id;
  final String? symbol;
  final String? type;
  final String? name;
  final String? icon;
  final String? status;
  final String? mechanism;
  final double? supply;
  final double? marketCap;
  final String? about;
  final String? services;
  final String? use;
  final String? visibility;

  Currency({
    this.id,
    this.symbol,
    this.type,
    this.name,
    this.icon,
    this.status,
    this.mechanism,
    this.supply,
    this.marketCap,
    this.about,
    this.services,
    this.use,
    this.visibility,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'] as int?,
      symbol: json['symbol'] as String?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      status: json['status'] as String?,
      mechanism: json['mechanism'] as String?,
      supply: _parseDouble(json['supply']),
      marketCap: _parseDouble(json['market_cap']),
      about: json['about'] as String?,
      services: json['services'] as String?,
      use: json['use'] as String?,
      visibility: json['visibility'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'type': type,
      'name': name,
      'icon': icon,
      'status': status,
      'mechanism': mechanism,
      'supply': supply,
      'market_cap': marketCap,
      'about': about,
      'services': services,
      'use': use,
      'visibility': visibility,
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

class Percentages {
  final double? halal;
  final double? haram;
  final double? questionable;

  Percentages({
    this.halal,
    this.haram,
    this.questionable,
  });

  factory Percentages.fromJson(Map<String, dynamic> json) {
    return Percentages(
      halal: _parseDouble(json['halal']),
      haram: _parseDouble(json['haram']),
      questionable: _parseDouble(json['questionable']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'halal': halal,
      'haram': haram,
      'questionable': questionable,
    };
  }

  static double? _parseDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }
}

