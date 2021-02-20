import 'package:flutter/material.dart';
import 'package:modal_queue/modal/modal_extension.dart';
import 'package:modal_queue/providers/ModalProvider.dart';
import 'package:modal_queue/pages/page_a.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ModalAware {
  ModalProvider _modalProv;

  @override
  Widget build(BuildContext context) {
    _modalProv = Provider.of<ModalProvider>(context);
    final _modals = _modalProv.modals;
    final _themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                return _modalProv.fetchInAppModals();
              },
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                children: <Widget>[
                  Card(
                    child: ListTile(
                      title: Text('Listener Attached'),
                      subtitle: Text('Listener state of the page'),
                      trailing: Text(
                        '${_modalProv.isListenerAttached(listenerKey)}',
                        style: _themeData.textTheme.headline6,
                      ),
                    ),
                  ),
                  ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    primary: false,
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => SizedBox(height: 16),
                    itemBuilder: (_, index) {
                      final _event = _modals[index];
                      return Card(
                          child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Icon(Icons.star),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${_event.title}',
                                      style: _themeData.textTheme.subtitle2
                                          .copyWith(
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '${_event.subtitle}',
                                      style: _themeData.textTheme.subtitle1,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                    },
                    itemCount: _modals.length,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          Container(
            margin: const EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 16,
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(PageA.id);
                    },
                    child: Text('Go to PageA'),
                    textColor: Colors.white,
                    color: _themeData.primaryColor,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  String get listenerKey => 'HomePage';

  @override
  ModalProvider get modalProv => _modalProv;
}
