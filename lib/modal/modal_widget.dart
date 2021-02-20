import 'package:flutter/material.dart';
import 'package:modal_queue/modal/inapp_modal.dart';

class ModalWidget extends StatelessWidget {
  final InAppModal modal;

  const ModalWidget(this.modal);

  @override
  Widget build(BuildContext context) {
    final _themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  child: Container(
                    child: Icon(Icons.close),
                    padding: const EdgeInsets.all(10),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 50,
                child: Icon(
                  Icons.thumb_up,
                  size: 50,
                  color: _themeData.primaryColor,
                ),
              ),
              SizedBox(height: 50),
              Text(
                '${modal.title}',
                style: _themeData.textTheme.headline5.copyWith(
                  fontSize: 24,
                  color: _themeData.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Text(
                '${modal.subtitle}',
                style: _themeData.textTheme.headline5.copyWith(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              if (modal.share != null) ...[
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Share'),
                ),
                SizedBox(height: 16),
              ],
              if (modal.deeplink != null) ...[
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Go to Link'),
                ),
                SizedBox(height: 16),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
