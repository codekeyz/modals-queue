import 'package:flutter/widgets.dart';
import 'package:async/async.dart';
import 'package:modal_queue/modal/modal_event.dart';
import 'package:modal_queue/common/alert_dialog.dart';
import 'package:modal_queue/common/dialog_template.dart';
import 'package:modal_queue/providers/ModalProvider.dart';

mixin ModalAware<T extends StatefulWidget> on State<T> {
  CancelableOperation _stateCheck;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => didBuild(context));
  }

  @protected
  void didBuild(BuildContext context) {
    _attachListener();

    _stateCheck = CancelableOperation.fromFuture(
      Future.doWhile(
        () async {
          await Future.delayed(Duration(milliseconds: 200));
          final _isCurrent = ModalRoute.of(context).isCurrent;
          if (_isCurrent) {
            // if widget is back in view
            if (!modalProv.isListenerAttached(listenerKey)) {
              _attachListener();
            }
            return true;
          }

          if (modalProv.isListenerAttached(listenerKey)) {
            _detachListener();
          }
          return true;
        },
      ),
    );
  }

  _attachListener() {
    modalProv.attachListener(listenerKey, onModalEvent);
  }

  _detachListener() {
    modalProv.detachListener(listenerKey);
  }

  void onModalEvent(ModalEvent event) {
    final _widget = event.widget;
    Navigator.of(context)
        .push(AlertDialogue(child: DialogTemplate(child: _widget)))
        .then((_) => event.ack());
  }

  @override
  void dispose() {
    _stateCheck?.cancel();
    _detachListener();
    super.dispose();
  }

  ModalProvider get modalProv;

  String get listenerKey;
}
