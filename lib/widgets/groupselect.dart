import 'package:flutter/material.dart';
import 'package:genesis/providers/new_user_provider.dart';
import 'package:genesis/widgets/groupchips.dart';
import 'package:provider/provider.dart';

class GroupSelection extends StatefulWidget {
  @override
  _GroupSelectionState createState() => _GroupSelectionState();
}

class _GroupSelectionState extends State<GroupSelection> {
  @override
  void initState() {
    Future.delayed(Duration(microseconds: 1)).then((value) {
      Provider.of<NewUserInfo>(context, listen: false).retrievegroups();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.red,
      onRefresh: () =>
          Provider.of<NewUserInfo>(context, listen: false).fetchgroups(),
      child: Container(
        child: Column(
          children: [
            const Text("Select the user-group for the user"),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
              child: GroupOptions(),
            )
          ],
        ),
      ),
    );
  }
}
