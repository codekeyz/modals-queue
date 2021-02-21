import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:modal_queue/modal/modal_event.dart';
import 'package:modal_queue/modal/inapp_modal.dart';
import 'package:modal_queue/modal/modal_widget.dart';
import 'package:modal_queue/services/serviceLocator.dart';

enum ModalProviderState { IDLE, BUSY }

typedef ModalListener = void Function(ModalEvent event);

class ModalProvider with ChangeNotifier {
  ModalProviderState _state = ModalProviderState.IDLE;

  Map<String, ModalListener> _modalListeners = {};

  int get listensCount => _modalListeners.values.length;

  bool isListenerAttached(String listenerKey) =>
      _modalListeners[listenerKey] != null;

  Timer _debounce;

  _acK() {
    if (_debounce?.isActive ?? false) return;
    _debounce = Timer(const Duration(seconds: 2), () {
      _state = ModalProviderState.IDLE;
      _sendUpdatesToUI();
    });
  }

  final Map<String, InAppModal> _queuedModalsInMemory = {};

  List<InAppModal> get modals => _queuedModalsInMemory.values.toList();

  attachListener(String key, ModalListener listener) {
    _modalListeners[key] = listener;
    notifyListeners();

    _acK();
  }

  detachListener(String key) {
    _modalListeners.remove(key);

    // if a listener still available after detaching $key, just proceed with updates
    if (listensCount > 0) {
      _acK();
      return;
    }

    if (_debounce?.isActive ?? false) {
      _debounce.cancel();
    }
  }

  Future<void> fetchInAppModals() async {
    final _result = await Future.delayed(
      Duration(seconds: 1),
      () => {
        'inAppModals': [
          {
            'title': 'Hurray',
            'subtitle': 'You just unlocked a new achievement',
            'id': '14493838KALA',
          },
          {
            'title': 'Whoopay!',
            'subtitle': 'You unlocked 10 mega achievements',
            'id': '13838KALA',
          },
          {
            'title': 'Mega! Mega!',
            'subtitle': 'You are first to make payments',
            'id': 'HWL2938LI',
          },
          {
            'title': "1st Runner",
            'subtitle': 'You just won the best user awards',
            'id': 'MALD3837',
            'share': 'I just came 1st on Modal Queue App',
          },
          {
            'title': "Alert!!!",
            'subtitle': 'We detected fraudulent events on your account',
            'id': 'KOL8839',
          }
        ]
      },
    );

    final _resultsList = (_result ?? {})['inAppModals'];
    _queuedModalsInMemory.clear();

    for (final e in _resultsList) {
      final _modal = InAppModal.fromJson(e);
      _queuedModalsInMemory[_modal.id] = _modal;
    }

    notifyListeners();
    _sendUpdatesToUI();
  }

  void _sendUpdatesToUI() {
    if (modals.isEmpty) return;
    final _modalToShow = modals.last;

    final _listeners = _modalListeners.values
        .toList(); // we expect this to only contain one tho;

    if (_listeners.isEmpty) {
      sl.get<Logger>().d('No Modal Listener available');
      return;
    }

    if (_state == ModalProviderState.BUSY) {
      sl.get<Logger>().d('Modal Provider is busy');
      return;
    }

    final _modalListener = _listeners.first;
    _state = ModalProviderState.BUSY;

    _modalListener(
      ModalEvent(
        widget: ModalWidget(_modalToShow),
        ack: () {
          _queuedModalsInMemory.remove(_modalToShow.id);
          notifyListeners();

          _acK();
        },
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
