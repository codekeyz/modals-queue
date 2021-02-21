import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modal_queue/services/serviceLocator.dart';
import 'package:modal_queue/providers/ModalProvider.dart';
import 'package:modal_queue/pages/home.dart';
import 'package:modal_queue/pages/page_b.dart';
import 'package:modal_queue/pages/page_c.dart';

import 'package:modal_queue/util/lifecycle_impl.dart';
import 'package:modal_queue/util/nav_observer.dart';

void main() async {
  await setupServiceLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ModalProvider>(
      create: (_) => ModalProvider(),
      child: MaterialApp(
        title: 'Modal Queue Demo',
        navigatorObservers: [
          NavigationObserver(sl.get<LifeCycleEventBus>().watcher),
        ],
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
        routes: {
          PageB.id: (_) => PageB(),
          PageC.id: (_) => PageC(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
