import 'package:flutter/material.dart';
import 'package:modal_queue/modal/modal_extension.dart';
import 'package:modal_queue/providers/ModalProvider.dart';
import 'package:provider/provider.dart';
import 'package:modal_queue/pages/page_c.dart';

class PageB extends StatefulWidget {
  static final String id = 'PageB';

  @override
  _PageBState createState() => _PageBState();
}

class _PageBState extends State<PageB> with ModalAware {
  ModalProvider _modalProv;

  @override
  Widget build(BuildContext context) {
    _modalProv = Provider.of<ModalProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Page B'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.orange,
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
                  Navigator.of(context).pushNamed(PageC.id);
                },
                child: Text('Go to Page C'),
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
  String get listenerKey => 'PageB';

  @override
  ModalProvider get modalProv => _modalProv;
}
