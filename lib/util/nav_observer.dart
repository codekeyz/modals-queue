import 'package:flutter/material.dart';

typedef void NavWatcher(
  NavAction action, {
  @required Route<dynamic> currentRoute,
  @required Route<dynamic> previousRoute,
});

enum NavAction { Push, Pop }

class NavigationObserver extends RouteObserver<PageRoute<dynamic>> {
  NavigationObserver(this.watcher);

  final NavWatcher watcher;

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      watcher(
        NavAction.Push,
        currentRoute: route,
        previousRoute: previousRoute,
      );
    }
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      watcher(
        NavAction.Pop,
        currentRoute: newRoute,
        previousRoute: oldRoute,
      );
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      watcher(
        NavAction.Pop,
        currentRoute: route,
        previousRoute: previousRoute,
      );
    }
  }
}
