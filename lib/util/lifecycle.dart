import 'package:meta/meta.dart';

abstract class WidgetLifeCycle {
  @protected
  void onResume();

  @protected
  void onPaused();
}
