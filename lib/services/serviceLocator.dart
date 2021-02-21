import 'package:logger/logger.dart';
import 'package:get_it/get_it.dart';

import 'package:modal_queue/util/lifecycle_impl.dart';

GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerSingleton<Logger>(Logger());
  sl.registerSingleton<LifeCycleEventBus>(LifeCycleEventBus());
}
