import 'package:logger/logger.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerSingleton<Logger>(Logger());
}
