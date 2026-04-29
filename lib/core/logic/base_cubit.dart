import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/core/networking/api_result.dart';

abstract class BaseCubit<T> extends Cubit<T> {
  static const defaultTimeout = Duration(seconds: 20);

  BaseCubit(super.initialState);

  Future<void> executeApi<R>({
    required Future<ApiResult<R>> Function() apiCall,
    required void Function(R data) onSuccess,
    required void Function(ErrorHandler error) onError,
    Duration timeout = defaultTimeout,
  }) async {
    try {
      final response = await apiCall().timeout(timeout);
      response.when(
        success: onSuccess,
        failure: onError,
      );
    } on TimeoutException catch (e) {
      onError(ErrorHandler.handle(e));
    } catch (e) {
      onError(ErrorHandler.handle(e));
    }
  }
}
