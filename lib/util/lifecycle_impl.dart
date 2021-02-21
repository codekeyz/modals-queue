import 'package:flutter/material.dart';
import 'package:modal_queue/util/nav_observer.dart';
import 'package:modal_queue/util/lifecycle.dart';

mixin LifeCycleMixin implements WidgetLifeCycle {
  @override
  void onPaused();

  @override
  void onResume();
}

class LifeCycleEventBus {
  final Map<String, LifeCycleMixin> _listenerMap = {};

  NavWatcher get watcher => (action, {currentRoute, previousRoute}) {
        switch (action) {
          case NavAction.Push:
            _checkAndFireOnPaused(currentRoute, previousRoute);
            break;

          case NavAction.Pop:
            _checkAndFireOnResume(previousRoute, currentRoute);
            break;
        }
      };

  /// For [LifeCycleMixin.onPaused] to be called, current route != previous route
  void _checkAndFireOnPaused(Route curr, Route prev) {
    // Current Route will be the current page that will recieve the OnResume callback
    final _currRoute = curr?.settings?.name;

    /// prev will be null if [curr.isFirst]
    if (prev != null) {
      final _prevRoute = prev?.settings?.name;
      if (!_listenerMap.containsKey(_prevRoute)) {
        _listenerMap[_prevRoute] = null;
      }
    }

    final _previousRoutes =
        _listenerMap.entries.where((k) => k.key != _currRoute).toList();
    if (_previousRoutes.isEmpty) return;

    final _listener = _previousRoutes.last.value;
    _listener?.onPaused();
  }

  /// For [LifeCycleMixin.onResume] to be called, we just try get listener for
  /// the current routeName, and notify
  void _checkAndFireOnResume(Route curr, Route prev) {
    final _currRoute = curr?.settings?.name;
    final _prevRoute = prev?.settings?.name;

    /// this block takes care of removing routes that have been popped
    if (prev != null) {
      if (_prevRoute != null && _listenerMap.containsKey(_prevRoute)) {
        _listenerMap.remove(_prevRoute);
      }

      // handle routes without name - NULL
      if (_prevRoute == null && curr.isFirst) {
        _listenerMap.remove(_prevRoute);
      }
    }

    final _currListener = _listenerMap[_currRoute];
    _currListener?.onResume();
  }

  attachListener(String routeName, LifeCycleMixin interface) {
    _listenerMap[routeName] = interface;
  }
}
