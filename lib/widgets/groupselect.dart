import 'package:flutter/material.dart';
import 'package:genesis/widgets/groupchips.dart';

class GroupSelection extends StatefulWidget {
  @override
  _GroupSelectionState createState() => _GroupSelectionState();
}

class _GroupSelectionState extends State<GroupSelection> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
