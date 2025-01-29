
import 'package:souq_ai/app/mvvm/model/response_model/zakatinstitutes_resp_model.dart';

import 'crypto_currenices_resp_model.dart';

class SignalsData {
  final List<Signal>? signals;
  final Pagination? pagination;

  SignalsData({this.signals, this.pagination});

  factory SignalsData.fromJson(Map<String, dynamic> json) {
    return SignalsData(
      signals: (json['signals'] as List<dynamic>?)
          ?.map((signal) => Signal.fromJson(signal))
          .toList(),
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'signals': signals?.map((signal) => signal.toJson()).toList(),
      'pagination': pagination?.toJson(),
    };
  }
}

class Signal {
  final int? id;
  final int? currencyId;
  final String? source;
  final double? buyFrom;
  final double? buyTo;
  final double? tp1;
  final double? tp2;
  final double? tp3;
  final double? sl;
  final int? isActive;
  final double? closedPrice;
  final double? currentPrice;
  final String? createdAt;
  final Currency? currency;

  Signal({
    this.id,
    this.currencyId,
    this.source,
    this.buyFrom,
    this.buyTo,
    this.tp1,
    this.tp2,
    this.tp3,
    this.sl,
    this.isActive,
    this.closedPrice,
    this.currentPrice,
    this.currency,
    this.createdAt,
  });

  factory Signal.fromJson(Map<String, dynamic> json) {
    return Signal(
      id: json['id'] as int?,
      currencyId: json['currency_id'] as int?,
      source: json['source'] as String?,
      createdAt: json['created_at'] as String?,
      buyFrom: _parseDouble(json['buy_from']),
      buyTo: _parseDouble(json['buy_to']),
      tp1: _parseDouble(json['tp1']),
      tp2: _parseDouble(json['tp2']),
      tp3: _parseDouble(json['tp3']),
      sl: _parseDouble(json['sl']),
      isActive: json['is_active'] as int?,
      closedPrice: _parseDouble(json['closed_price']),
      currentPrice: _parseDouble(json['current_price']),
      currency: json['currency'] != null
          ? Currency.fromJson(json['currency'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'currency_id': currencyId,
      'source': source,
      'buy_from': buyFrom,
      'buy_to': buyTo,
      'tp1': tp1,
      'tp2': tp2,
      'tp3': tp3,
      'sl': sl,
      'is_active': isActive,
      'closed_price': closedPrice,
      'current_price': currentPrice,
      'created_at': createdAt,
      'currency': currency?.toJson(),
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


