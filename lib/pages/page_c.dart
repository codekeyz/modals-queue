import 'package:flutter/material.dart';

class PageC extends StatefulWidget {
  static final String id = 'PageC';

  @override
  _PageCState createState() => _PageCState();
}

class _PageCState extends State<PageC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          height: double.infinity,
          color: Colors.grey,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Page C',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 24),
              Container(
                margin: const EdgeInsets.only(left: 24, right: 24),
                child: SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((_) => _.isFirst);
                    },
                    child: Text('Go to Home'),
                    // textColor: Colors.white,
                    color: Colors.orange,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
