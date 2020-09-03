import 'package:flutter/material.dart';
import 'package:genesis/widgets/groupselect.dart';
import 'package:genesis/widgets/new_user_form.dart';
import 'package:genesis/widgets/new_user_nav.dart';

class Newuser extends StatelessWidget {
  final PageController _controller = new PageController();
  final List<TextEditingController> _list = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    final FocusScopeNode _currentFocus = FocusScope.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add a new user"),
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          pageSnapping: false,
          controller: _controller,
          allowImplicitScrolling: false,
          children: [
            NewuserForm(this._list),
            Container(
              child: Text("TO DO IMAGE INSERSTION!"),
            ),
            GroupSelection(),
          ],
        ),
        floatingActionButton: NewUserNav(_controller, _list, _currentFocus));
  }
}
