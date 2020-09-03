import 'package:flutter/material.dart';
import 'package:genesis/providers/myinfo.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME"),
      ),
      body: Center(
        child: FlatButton(
            onPressed: () {
              Provider.of<MyInfo>(context, listen: false).retrieveinfo();
            },
            child: Text("PRESS KR")),
      ),
    );
  }
}
