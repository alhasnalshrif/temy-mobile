import 'package:dio/dio.dart';

import 'api_constants.dart';
import 'api_error_model.dart';

enum DataSource {
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout, // Fixed the spelling from RECIEVE to RECEIVE
  sendTimeout,
  cacheError,
  noInternetConnection,
  default_
}

class ResponseCode {
  // Success codes
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no content

  // Error codes
  static const int badRequest = 400; // API rejected request
  static const int unauthorized = 401; // user is not authorized
  static const int forbidden = 403; // API rejected request
  static const int notFound = 404; // not found
  static const int apiLogicError = 422; // API logic error
  static const int internalServerError = 500; // server-side crash

  // Local status codes
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3; // Fixed spelling
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int default_ = -7;
}

class ResponseMessage {
  // Success messages
  static const String noContent = ApiErrors.noContent;

  // Error messages
  static const String badRequest = ApiErrors.badRequestError;
  static const String unauthorized = ApiErrors.unauthorizedError;
  static const String forbidden = ApiErrors.forbiddenError;
  static const String notFound = ApiErrors.notFoundError;
  static const String internalServerError = ApiErrors.internalServerError;

  // Local error messages
  static String connectTimeout = ApiErrors.timeoutError;
  static String cancel = ApiErrors.defaultError;
  static String receiveTimeout = ApiErrors.timeoutError; // Fixed spelling
  static String sendTimeout = ApiErrors.timeoutError;
  static String cacheError = ApiErrors.cacheError;
  static String noInternetConnection = ApiErrors.noInternetError;
  static String default_ = ApiErrors.defaultError;
}

extension DataSourceExtension on DataSource {
  ApiErrorModel getFailure() {
    switch (this) {
      case DataSource.noContent:
        return ApiErrorModel(
            code: ResponseCode.noContent, message: ResponseMessage.noContent);
      case DataSource.badRequest:
        return ApiErrorModel(
            code: ResponseCode.badRequest, message: ResponseMessage.badRequest);
      case DataSource.forbidden:
        return ApiErrorModel(
            code: ResponseCode.forbidden, message: ResponseMessage.forbidden);
      case DataSource.unauthorized:
        return ApiErrorModel(
            code: ResponseCode.unauthorized,
            message: ResponseMessage.unauthorized);
      case DataSource.notFound:
        return ApiErrorModel(
            code: ResponseCode.notFound, message: ResponseMessage.notFound);
      case DataSource.internalServerError:
        return ApiErrorModel(
            code: ResponseCode.internalServerError,
            message: ResponseMessage.internalServerError);
      case DataSource.connectTimeout:
        return ApiErrorModel(
            code: ResponseCode.connectTimeout,
            message: ResponseMessage.connectTimeout);
      case DataSource.cancel:
        return ApiErrorModel(
            code: ResponseCode.cancel, message: ResponseMessage.cancel);
      case DataSource.receiveTimeout: // Fixed spelling
        return ApiErrorModel(
            code: ResponseCode.receiveTimeout,
            message: ResponseMessage.receiveTimeout);
      case DataSource.sendTimeout:
        return ApiErrorModel(
            code: ResponseCode.sendTimeout,
            message: ResponseMessage.sendTimeout);
      case DataSource.cacheError:
        return ApiErrorModel(
            code: ResponseCode.cacheError, message: ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return ApiErrorModel(
            code: ResponseCode.noInternetConnection,
            message: ResponseMessage.noInternetConnection);
      case DataSource.default_:
        return ApiErrorModel(
            code: ResponseCode.default_, message: ResponseMessage.default_);
    }
  }
}

class ErrorHandler implements Exception {
  late ApiErrorModel apiErrorModel;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself
      apiErrorModel = _handleError(error);
    } else {
      // default error
      apiErrorModel = DataSource.default_.getFailure();
    }
  }
}

ApiErrorModel _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeout.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeout.getFailure();
    case DioExceptionType.receiveTimeout: // Fixed spelling
      return DataSource.receiveTimeout.getFailure();
    case DioExceptionType.badResponse:
      return _handleResponseError(error);
    case DioExceptionType.unknown:
      return _handleResponseError(error);
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.noInternetConnection.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.default_.getFailure();
  }
}

// Helper method to handle response errors
ApiErrorModel _handleResponseError(DioException error) {
  if (error.response != null && error.response?.statusCode != null) {
    // Check if status code is 200 or 201 (success cases)
    if (error.response!.statusCode == ResponseCode.success ||
        error.response!.statusCode == ResponseCode.noContent) {
      // Return success with no content for these status codes
      return ApiErrorModel(
          code: error.response!.statusCode!,
          message: error.response!.statusCode == ResponseCode.success
              ? "Success"
              : ResponseMessage.noContent);
    }

    // Try to parse error from response
    try {
      return ApiErrorModel.fromJson(error.response!.data);
    } catch (_) {
      // If parsing fails, return a default error based on status code
      return _getErrorForStatusCode(error.response!.statusCode!);
    }
  } else {
    return DataSource.default_.getFailure();
  }
}

// Helper method to get appropriate error for status code
ApiErrorModel _getErrorForStatusCode(int statusCode) {
  switch (statusCode) {
    case 400:
      return DataSource.badRequest.getFailure();
    case 401:
      return DataSource.unauthorized.getFailure();
    case 403:
      return DataSource.forbidden.getFailure();
    case 404:
      return DataSource.notFound.getFailure();
    case 500:
      return DataSource.internalServerError.getFailure();
    default:
      return DataSource.default_.getFailure();
  }
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
