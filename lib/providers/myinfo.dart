import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:genesis/providers/new_user_provider.dart';

class MyInfo with ChangeNotifier {
  String name;
  int rollNo;
  String branch;
  List<UserGroup> groups;

  void retrieveinfo() {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser.uid);
      FirebaseAuth.instance.currentUser.uid;
      http
          .post('https://us-central1-genesis-51029.cloudfunctions.net/myinfo',
              body: jsonEncode({'uid': FirebaseAuth.instance.currentUser.uid}))
          .then((value) {
        var va = jsonDecode(value.body);
        var val = va[0];

        name = val['name'];
        rollNo = val['rollNo'];
        branch = val['branch'];
        groups = [];
        final List<dynamic> v = val['groups'];
        v.forEach((e) => groups.add(UserGroup(name: e['name'], id: e['id'])));
      });
    }
  }
}
