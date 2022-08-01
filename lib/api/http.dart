import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'error.dart';

const Map<String, String> defaultHeaders = {
  'Content-type': 'application/json',
};

Future<dynamic> postJson(String url, Object body,
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
        if (error is SocketException) {
          String errorMessage = "No internet or api offline";
          debugPrint("--> error: $errorMessage");
        }
      });
}

// Future<dynamic> getJson(String url, {Map<String, String>? headers} ) {
//   return http
//       .get(Uri.parse(url), headers: {...defaultHeaders, ...?headers})
//       .timeout(const Duration(minutes: 2))
//       .then((response) {
//     "--> response ${response.statusCode} $url".log(Reaction.info);
//     if (response.statusCode <= 230 && response.statusCode >= 200) {
//       return jsonDecode(response.body);
//     }
//     switch (response.statusCode) {
//       case 400:
//         throw BadRequestException(response.body.toString());
//       case 401:
//       case 403:
//         throw UnauthorisedException(response.body.toString());
//       case 500:
//       default:
//         final error = ApiError(
//             'Error occurred while communication with server with status_code: ${response.statusCode} and url $url');
//         FirebaseCrashlytics.instance.recordError(error, null);
//         throw error;
//     }
//   }, onError: (error) {
//     "--> API ERROR $url".log(Reaction.error);
//     if (error is SocketException) {
//       String errorMessage = "No internet or api offline";
//       debugPrint("--> error: $errorMessage");
//       throw RemoteSourceNotAvailable(errorMessage);
//     }
//     debugPrint(error.runtimeType.toString());
//     throw ApiError("Unexpected error occurred");
//   });
// }