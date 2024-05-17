// ignore_for_file: overridden_fields

import 'package:equatable/equatable.dart';

import 'error_handler.dart';

class Failure extends Equatable {
  final int code;
  final String message;
  final Map<String, dynamic>? data;

  const Failure(
      {this.code = ResponseCode.unknown,
      this.message = ResponseMessage.unknown,
      this.data});

  @override
  List<Object?> get props => [code, message, data];
}

class ServerFailure extends Failure {
  const ServerFailure(
      {required int code, required String message, required dynamic data})
      : super(code: code, message: message, data: data);
}

class NoConnectionFailure extends Failure {
  const NoConnectionFailure(
      {int code = ResponseCode.noInternetConnection,
      String message = ResponseMessage.noInternetConnection,
      dynamic data})
      : super(code: code, message: message, data: data);
}

class CacheFailure extends Failure {
  const CacheFailure(
      {int code = ResponseCode.cacheError,
      String message = ResponseMessage.cacheError,
      data})
      : super(code: code, message: message, data: data);
}

class StripeFailure extends Failure {
  const StripeFailure(
      {code = ResponseCode.stripeError,
      message = ResponseMessage.stripeError,
      data})
      : super(code: code, message: message, data: data);
}

class HiveFailure extends Failure {
  const HiveFailure(
      {code = ResponseCode.hiveError,
      message = ResponseMessage.hiveError,
      data})
      : super(code: code, message: message, data: data);
}
