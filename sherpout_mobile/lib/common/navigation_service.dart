import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigatorKey;

  NavigationService(this._navigatorKey);

  BuildContext? get context => _navigatorKey.currentContext;

  GoRouter get _router => GoRouter.of(context!);

  void go(String path) {
    if (context != null) {
      _router.go(path);
    }
  }

  void push(String path) {
    if (context != null) {
      _router.push(path);
    }
  }

  void replace(String path) {
    if (context != null) {
      _router.replace(path);
    }
  }

  void pop() {
    _navigatorKey.currentState?.pop();
  }
}