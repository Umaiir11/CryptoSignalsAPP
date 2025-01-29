import 'package:souq_ai/app/mvvm/model/response_model/profit_analysis_resp_model.dart';

class ApiResponse<T> {
  final bool? success;
  final String? message;
  final T? data;
  final String? token; // Nullable token field

  ApiResponse({
    this.success,
    this.message,
    this.data,
    this.token,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT,
      ) {
    return ApiResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      token: json['data']?['token'] as String?, // Access token if available

    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'success': success,
      'message': message,
      'data': data != null ? toJsonT(data!) : null,
      'token': token,
    };
  }
}

