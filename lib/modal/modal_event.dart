import 'package:flutter/material.dart';

class ModalEvent {
  final Widget widget;

  // UI should be able to notify us that modal was showed; // so we can handle pushing multiple modal events
  final Function ack;

  const ModalEvent({
    this.widget,
    this.ack,
  });
}
