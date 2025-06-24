import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:infixedu/app/database/auth_database.dart';
import 'package:infixedu/app/utilities/message/snack_bars.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AppException implements Exception {
  final String? message;
  final String? prefix;

  AppException([this.message, this.prefix]);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, "");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

dynamic returnResponse(http.Response response) {
  final AuthDatabase authDatabase = AuthDatabase.instance;
  debugPrint(response.body);
  switch (response.statusCode) {
    case HttpStatus.ok:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case HttpStatus.badRequest:
      throw BadRequestException(response.body.toString());
    case HttpStatus.found:
      showBasicFailedSnackBar(message: 'Something went wrong'.tr);
      throw BadRequestException(response.body.toString());
    case HttpStatus.conflict:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case HttpStatus.unauthorized:
      showBasicFailedSnackBar(
          message: json.decode(response.body.toString())["message"]);

      if (json.decode(response.body.toString())["message"] ==
          'Unauthenticated.') {
        authDatabase.logOut();
        Future.delayed(const Duration(seconds: 2)).then((val) {
          Get.offNamedUntil('/secondary-splash', (route) => false);
          // Get.offNamedUntil('/splash', (route) => false);
        });
      }

    case HttpStatus.forbidden:
      showBasicFailedSnackBar(
          message: json.decode(response.body.toString())["message"]);
      throw UnauthorisedException(response.body.toString());
    case HttpStatus.internalServerError:
    default:
      showBasicFailedSnackBar(
          message: json.decode(response.body.toString())["message"]);
      throw json.decode(response.body.toString());
  }
}
