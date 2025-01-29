import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:souq_ai/app/mvvm/model/bodymodel/update_user_bodymodel.dart';
import 'package:souq_ai/app/services/shared_preferences_helper.dart';

import '../config/app_urls.dart';

import '../mvvm/model/bodymodel/signup_bodymodel.dart';

class HttpsCalls {
  final _ongoingRequests = <String, Future<http.Response>>{};
  final Duration _timeoutDuration = Duration(seconds: 20);
  final int _maxRetries = 2;

  Future<http.Response> _performRequest(String key, Future<http.Response> Function() request) async {
    if (_ongoingRequests.containsKey(key)) {
      return _ongoingRequests[key]!;
    }

    for (int retryCount = 0; retryCount <= _maxRetries; retryCount++) {
      try {
        final responseFuture = request().timeout(_timeoutDuration);
        _ongoingRequests[key] = responseFuture;
        return await responseFuture;
      } on TimeoutException catch (e) {
        if (retryCount == _maxRetries) {
          throw Exception('Request timed out after $_maxRetries retries: $e');
        }
        await Future.delayed(Duration(seconds: 2 * retryCount));
      } catch (e, stackTrace) {
        if (retryCount == _maxRetries) {
          throw Exception('Request failed after $_maxRetries retries: $e\n$stackTrace');
        }
        await Future.delayed(Duration(seconds: 2 * retryCount));
      }
    }

    throw Exception('Failed to perform request');
  }

  Future<Map<String, String>> _getDefaultHeaders() async {
    final token = await SharedPreferencesService().readToken();
    String? accessToken = token;
    return {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $accessToken',
    };
  }

  Future<http.Response> postApiHits(String lControllerUrl, List<int>? lUtfContent) {
    return _performRequest(lControllerUrl, () async {
      final headers = await _getDefaultHeaders();
      final url = Uri.parse(ApiUrls.baseAPIURL + lControllerUrl);

      return await http.post(
        url,
        headers: headers,
        body: lUtfContent != null ? lUtfContent : null,
      );
    });
  }

  Future<http.Response> getApiHits(String lControllerUrl) {
    return _performRequest(lControllerUrl, () async {
      final headers = await _getDefaultHeaders();
      final url = Uri.parse(ApiUrls.baseAPIURL + lControllerUrl);
      return await http.get(url, headers: headers);
    });
  }

  Future<http.Response> putApiHits(String lControllerUrl, List<int> lUtfContent) {
    return _performRequest(lControllerUrl, () async {
      final headers = await _getDefaultHeaders();
      final url = Uri.parse(ApiUrls.baseAPIURL + lControllerUrl);
      return await http.put(url, headers: headers, body: lUtfContent);
    });
  }

  Future<http.Response> patchApiHits(String lControllerUrl, List<int> lUtfContent) {
    return _performRequest(lControllerUrl, () async {
      final headers = await _getDefaultHeaders();
      final url = Uri.parse(ApiUrls.baseAPIURL + lControllerUrl);
      return await http.patch(url, headers: headers, body: lUtfContent);
    });
  }

  Future<http.Response> deleteApiHits(String lControllerUrl, List<int>? lUtfContent) {
    return _performRequest(lControllerUrl, () async {
      final headers = await _getDefaultHeaders();
      final url = Uri.parse(ApiUrls.baseAPIURL + lControllerUrl);

      // Check if lUtfContent is null and construct the request accordingly
      if (lUtfContent == null) {
        return await http.delete(url, headers: headers);
      } else {
        return await http.delete(url, headers: headers, body: lUtfContent);
      }
    });
  }


  Future<http.Response> multipartProfileApiHits(String lControllerUrl, SignupBodyModel profileMultipart) {
    return _performRequest(lControllerUrl, () async {
      final token = await SharedPreferencesService().readToken();

      String url = ApiUrls.baseAPIURL + lControllerUrl;
      Uri lUri = Uri.parse(url);
      var request = http.MultipartRequest('POST', lUri);

      request.headers.addAll({
        HttpHeaders.contentTypeHeader: 'multipart/form-data',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });

      var modelJson = profileMultipart.toJson();

      modelJson.forEach((key, value) {
        if (value is String) {
          request.fields[key] = value;
        } else if (value is int || value is double) {
          request.fields[key] = value.toString();
        }
      });

      if (profileMultipart.profileImage != null) {
        var file = await http.MultipartFile.fromPath('profile_pic', profileMultipart.profileImage!.path);
        request.files.add(file);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response;
    });
  }

  Future<http.Response> multipartUpdateProfileApiHits(String lControllerUrl, UpdateBodyModel profileMultipart) {
    return _performRequest(lControllerUrl, () async {
      final token = await SharedPreferencesService().readToken();

      String url = ApiUrls.baseAPIURL + lControllerUrl;
      Uri lUri = Uri.parse(url);
      var request = http.MultipartRequest('POST', lUri);

      request.headers.addAll({
        HttpHeaders.contentTypeHeader: 'multipart/form-data',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });

      var modelJson = profileMultipart.toJson();

      modelJson.forEach((key, value) {
        if (value is String) {
          request.fields[key] = value;
        } else if (value is int || value is double) {
          request.fields[key] = value.toString();
        }
      });

      if (profileMultipart.profileImage != null) {
        var file = await http.MultipartFile.fromPath('profile_pic', profileMultipart.profileImage!.path);
        request.files.add(file);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return response;
    });
  }




}
