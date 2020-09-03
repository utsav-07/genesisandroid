import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserGroup {
  int id;
  String name;
  bool isSelected;
  UserGroup({this.name, this.isSelected = false});
}

class NewUserInfo with ChangeNotifier {
  void fetchgroups() {
    http
        .get('https://us-central1-genesis-51029.cloudfunctions.net/fetchgroups')
        .then((value) {
      print("VALKUEE");
      print(value.body);
    }); // TODO
  }

  Future<void> retrievegroups() async {
    SharedPreferences.getInstance()
        .then((value) => value.getString('groups'))
        .catchError((e) async {
      print(e);
      fetchgroups();
    });
  }

  Future<int> submit(List<TextEditingController> _list) async {
    int i = 0;

    _list.forEach((e) {
      if (e.text.isEmpty) {
        switch (i) {
          case 0:
            throw "Invalid Name";
          case 1:
            throw "Invalid Roll Number";
          case 2:
            throw "Invalid Year";
          case 3:
            throw "Invalid Branch";
          case 4:
            throw "Invalid Email";
          case 5:
            throw "Invalid Password";
        }
      }
      i++;
    });
    // if (!_list[4].text.contains('@kiit.ac.in')) {
    //   throw "Invalid Email ID ( Please use kiit email address )";
    // }
    // final _core = Firebase.initializeApp();
    if (selectedgroups.length == 0) {
      throw "Select atleast one usergroup";
    }

    final _auth = FirebaseAuth.instance;
    return _auth
        .createUserWithEmailAndPassword(
            email: _list[4].text, password: _list[5].text)
        .then((value) {
      http
          .post(
              'https://us-central1-genesis-51029.cloudfunctions.net/createuser',
              body: jsonEncode(({
                'name': _list[0].text,
                'rollNo': int.parse(_list[1].text),
                'year': _list[2].text,
                'branch': _list[3].text,
                'email': _list[4].text,
                'groups': selectedgroups
              })))
          .then((value) => print(value.body))
          .catchError((er) {
        print("FF");
        print(er);
      });
    }).catchError((err) {
      print(err);
      throw "An Error Occoured";
    });
  }

  List<UserGroup> usergroups = [
    UserGroup(
      name: "Coding",
    ),
    UserGroup(name: "Designing"),
    UserGroup(name: "Chicken"),
    UserGroup(name: "Biryani")
  ];
  List<Map<String, dynamic>> selectedgroups = [];

  List<UserGroup> get getgroups {
    return [...usergroups];
  }

  void selectgroup(int id) {
    usergroups[id].isSelected = !usergroups[id].isSelected;
    usergroups[id].isSelected
        ? selectedgroups.add({'id': id, 'name': usergroups[id].name})
        : selectedgroups.removeWhere((element) => element['id'] == id);
    notifyListeners();
  }
}
