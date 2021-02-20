import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modal_queue/services/serviceLocator.dart';
import 'package:modal_queue/providers/ModalProvider.dart';
import 'package:modal_queue/pages/home.dart';
import 'package:modal_queue/pages/page_a.dart';
import 'package:modal_queue/pages/page_b.dart';
import 'package:modal_queue/pages/page_c.dart';

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
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
        routes: {
          PageA.id: (_) => PageA(),
          PageB.id: (_) => PageB(),
          PageC.id: (_) => PageC(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
