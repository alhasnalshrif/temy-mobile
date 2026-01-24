import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

extension Navigation on BuildContext {

  void pop() => Navigator.of(this).pop();

  // GoRouter methods for URL-based navigation
  void goNamed(
    String name, {
    Map<String, String>? pathParameters,
    Object? extra,
  }) {
    GoRouter.of(
      this,
    ).goNamed(name, pathParameters: pathParameters ?? {}, extra: extra);
  }

  Future<T?> pushGoNamed<T>(
    String name, {
    Map<String, String>? pathParameters,
    Object? extra,
  }) {
    return GoRouter.of(
      this,
    ).pushNamed<T>(name, pathParameters: pathParameters ?? {}, extra: extra);
  }

  void go(String location, {Object? extra}) {
    GoRouter.of(this).go(location, extra: extra);
  }

  Future<T?> push<T>(String location, {Object? extra}) {
    return GoRouter.of(this).push<T>(location, extra: extra);
  }

  void popGo() {
    if (GoRouter.of(this).canPop()) {
      GoRouter.of(this).pop();
    }
  }
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
}

extension ListExtension<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}
