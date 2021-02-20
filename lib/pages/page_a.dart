import 'package:flutter/material.dart';
import 'package:modal_queue/pages/page_b.dart';

class PageA extends StatefulWidget {
  static final String id = 'PageA';

  @override
  _PageAState createState() => _PageAState();
}

class _PageAState extends State<PageA> {
  @override
  Widget build(BuildContext context) {
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
}
