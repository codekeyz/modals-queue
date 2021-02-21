import 'package:flutter/material.dart';
import 'package:modal_queue/pages/page_b.dart';
import 'package:modal_queue/services/serviceLocator.dart';
import 'package:logger/logger.dart';
import 'package:modal_queue/util/lifecycle_impl.dart';

class PageA extends StatelessWidget with LifeCycleMixin {
  static final String id = 'PageA';

  @override
  Widget build(BuildContext context) {
    sl.get<LifeCycleEventBus>().attachListener(PageA.id, this);

    return Scaffold(
      appBar: AppBar(
        title: Text('Page A'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.indigo,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 24,
            ),
            child: SizedBox(
              height: 45,
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(PageB.id);
                },
                child: Text('Go to Page B'),
                // textColor: Colors.white,
                color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onPaused() {
    sl.get<Logger>().d('PageA is paused.');
  }

  @override
  void onResume() {
    sl.get<Logger>().d('PageA is resumed.');
  }
}
