import 'package:flutter/widgets.dart';
import 'package:modal_queue/modal/modal_event.dart';
import 'package:modal_queue/common/alert_dialog.dart';
import 'package:modal_queue/common/dialog_template.dart';
import 'package:modal_queue/providers/ModalProvider.dart';

mixin ModalAware<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => didBuild(context));
  }

  @protected
  void didBuild(BuildContext context) {
    attachModalListener();
  }

  attachModalListener() {
    modalProv.attachListener(listenerKey, onModalEvent);
  }

  detachModalListener() {
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
    detachModalListener();
    super.dispose();
  }

  ModalProvider get modalProv;

  String get listenerKey;
}
