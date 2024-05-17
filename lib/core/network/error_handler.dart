import 'package:dio/dio.dart';

import '../errors/exceptions.dart';
import 'failure.dart';

enum DataSource {
  succes,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internetServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimout,
  cacheError,
  noInternetConnection,
  unknown,
}

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // dio error its error from response api
      failure = _handleError(error);
    } else if (error is CacheException) {
      failure = const CacheFailure();
    } else {
      failure = DataSource.unknown.getFailure();
    }
  }

  Failure _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.connectTimeout.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.sendTimout.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case ResponseCode.badRequest:
            return DataSource.badRequest
                .getResponseFailure(error.response as Response);
          case ResponseCode.forbidden:
            return DataSource.forbidden.getFailure();
          case ResponseCode.unauthorized:
            return DataSource.unauthorized.getFailure();
          case ResponseCode.notFound:
            return DataSource.notFound.getFailure();
          case ResponseCode.internetServerError:
            return DataSource.internetServerError.getFailure();
          default:
            return DataSource.internetServerError.getFailure();
        }
      case DioExceptionType.unknown:
        switch (error.response?.statusCode) {
          case ResponseCode.badRequest:
            return DataSource.badRequest
                .getResponseFailure(error.response as Response);
          case ResponseCode.forbidden:
            return DataSource.forbidden.getFailure();
          case ResponseCode.unauthorized:
            return DataSource.unauthorized.getFailure();
          case ResponseCode.notFound:
            return DataSource.notFound.getFailure();
          case ResponseCode.internetServerError:
            return DataSource.internetServerError.getFailure();
          default:
            return DataSource.internetServerError.getFailure();
        }

      default:
        return DataSource.connectTimeout.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getResponseFailure(Response response) {
    return Failure(
        code: ResponseCode.badRequest,
        message: ResponseMessage.badRequest,
        data: response.data as Map<String, dynamic>);
  }

  Failure getFailure() {
    switch (this) {
      case DataSource.badRequest:
        return const Failure(
          code: ResponseCode.badRequest,
          message: ResponseMessage.badRequest,
        );
      case DataSource.unauthorized:
        return const Failure(
            code: ResponseCode.unauthorized,
            message: ResponseMessage.unauthorized);

      case DataSource.notFound:
        return const Failure(
            code: ResponseCode.notFound, message: ResponseMessage.notFound);

      case DataSource.internetServerError:
        return const Failure(
            code: ResponseCode.internetServerError,
            message: ResponseMessage.internetServerError);

      case DataSource.connectTimeout:
        return const Failure(
            code: ResponseCode.connectTimeout,
            message: ResponseMessage.connectTimeout);

      case DataSource.cancel:
        return const Failure(
            code: ResponseCode.cancel, message: ResponseMessage.cacheError);

      case DataSource.receiveTimeout:
        return const Failure(
            code: ResponseCode.receiveTimeout,
            message: ResponseMessage.receiveTimeout);

      case DataSource.sendTimout:
        return const Failure(
            code: ResponseCode.sendTimeout,
            message: ResponseMessage.sendTimeout);

      case DataSource.cacheError:
        return const Failure(
            code: ResponseCode.cacheError, message: ResponseMessage.cacheError);

      case DataSource.noInternetConnection:
        return const Failure(
            code: ResponseCode.noInternetConnection,
            message: ResponseMessage.noInternetConnection);

      case DataSource.forbidden:
        return const Failure(
            code: ResponseCode.forbidden, message: ResponseMessage.forbidden);
      default:
        return const Failure(
            code: ResponseCode.unknown, message: ResponseMessage.unknown);
    }
  }
}

class ResponseCode {
  // Api Status code
  static const int succes = 200;
  static const int noContent = 200;
  static const int badRequest = 422;
  static const int forbidden = 403;
  static const int unauthorized = 401;
  static const int noDevicePermission = 434;
  static const int notFound = 404;
  static const int internetServerError = 500;
  static const int noInternetConnection = 503;

  // stripe status code
  static const int stripeError = -10;

  // local status code
  static const int connectTimeout = -1;
  static const int unknown = -2;
  static const int cancel = -3;
  static const int receiveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheError = -6;
  static const int hiveError = -7;
}

class ResponseMessage {
  static const String noDevicePermission = 'errors.no_device_permission';
  static const String badRequest = 'errors.bad_request';
  static const String forbidden = 'errors.forbidden';
  static const String unauthorized = 'errors.unauthorized';
  static const String notFound = 'errors.not_found';
  static const String internetServerError = 'errors.internet_server_error';
  static const String stripeError = 'errors.stripe';

  // local status code
  static const String connectTimeout = 'errors.connect_timeout';
  static const String unknown = 'errors.unknown';
  static const String cancel = "request was canceled , try again later";
  static const String receiveTimeout = 'errors.connect_timeout';
  static const String sendTimeout = 'errors.connect_timeout';
  static const String cacheError = 'errors.cache_error';
  static const String noInternetConnection = 'errors.no_internet_connection';
  static const String hiveError = 'errors.hive_error';
}
