import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'error.dart';

const Map<String, String> defaultHeaders = {
  'Content-type': 'application/json',
};

Future<dynamic> postJson(String url, Object body, context,
    {Map<String, String>? headers}) {
  return http
      .post(Uri.parse(url),
          body: jsonEncode(body), headers: {...defaultHeaders, ...?headers})
      .timeout(const Duration(minutes: 2))
      .then((response) {
        if (response.statusCode <= 230 && response.statusCode >= 200) {
          return jsonDecode(response.body);
        }
        switch (response.statusCode) {
          case 400:
            throw BadRequestException(response.body.toString());
          case 401:
          case 403:
            throw UnauthorisedException(response.body.toString());
          case 500:
          default:
            final error = ApiError(
                'Error occurred while communication with server with status_code: ${response.statusCode} and url $url');
        }
      }, onError: (error) {
        Navigator.pop(context);
        if (error is SocketException) {
          String errorMessage = "No internet or api offline";
          debugPrint("--> error: $errorMessage");
        }
      });
}

Future<dynamic> getJson(String url, {Map<String, String>? headers}) {
  return http
      .get(Uri.parse(url), headers: {...defaultHeaders, ...?headers})
      .timeout(const Duration(minutes: 2))
      .then((response) {
        if (response.statusCode <= 230 && response.statusCode >= 200) {
          return jsonDecode(response.body);
        }
        switch (response.statusCode) {
          case 400:
            throw BadRequestException(response.body.toString());
          case 401:
          case 403:
            throw UnauthorisedException(response.body.toString());
          case 500:
          default:
            final error = ApiError(
                'Error occurred while communication with server with status_code: ${response.statusCode} and url $url');
        }
      }, onError: (error) {
        if (error is SocketException) {
          String errorMessage = "No internet or api offline";
          debugPrint("--> error: $errorMessage");
          throw RemoteSourceNotAvailable(errorMessage);
        }
        debugPrint(error.runtimeType.toString());
        throw ApiError("Unexpected error occurred");
      });
}

Future<dynamic> putJson(String url, Object body, context,
    {Map<String, String>? headers}) {
  return http
      .put(Uri.parse(url),
          body: jsonEncode(body), headers: {...defaultHeaders, ...?headers})
      .timeout(const Duration(minutes: 2))
      .then((response) {
        if (response.statusCode <= 230 && response.statusCode >= 200) {
          return jsonDecode(response.body);
        }
        switch (response.statusCode) {
          case 400:
            throw BadRequestException(response.body.toString());
          case 401:
          case 403:
            throw UnauthorisedException(response.body.toString());
          case 500:
          default:
            final error = ApiError(
                'Error occurred while communication with server with status_code: ${response.statusCode} and url $url');
        }
      }, onError: (error) {
        if (error is SocketException) {
          String errorMessage = "No internet or api offline";
          debugPrint("--> error: $errorMessage");
          throw RemoteSourceNotAvailable(errorMessage);
        }
        debugPrint(error.runtimeType.toString());
        throw ApiError("Unexpected error occurred");
      });
}

Future<dynamic> putWithImageJson(String url, Map<String, String> body, context,
    Map<String, String> headers, path) async {
  var request = http.MultipartRequest('PUT', Uri.parse(url));
  request.fields.addAll(body);
  request.files.add(await http.MultipartFile.fromPath('profile', path));
  request.headers.addAll(headers);

  await request.send().then((response) async {
    var responseString = await response.stream.bytesToString();
    if (response.statusCode <= 230 && response.statusCode >= 200) {
      return jsonDecode(responseString);
    }
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(responseString.toString());
      case 401:
      case 403:
        throw UnauthorisedException(responseString.toString());
      case 500:
      default:
        final error = ApiError(
            'Error occurred while communication with server with status_code: ${response.statusCode} and url $url');
    }
  }, onError: (error) {
    if (error is SocketException) {
      String errorMessage = "No internet or api offline";
      debugPrint("--> error: $errorMessage");
      throw RemoteSourceNotAvailable(errorMessage);
    }
    debugPrint(error.runtimeType.toString());
    throw ApiError("Unexpected error occurred");
  });
}
