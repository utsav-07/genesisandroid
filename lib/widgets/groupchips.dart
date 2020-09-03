import 'package:flutter/material.dart';
import 'package:genesis/providers/new_user_provider.dart';
import 'package:provider/provider.dart';

class GroupOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _g = Provider.of<NewUserInfo>(context);
    List<UserGroup> _groups = _g.getgroups;
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (ctx, i) => FilterChip(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        selected: _groups[i].isSelected,
        selectedColor: Colors.blue,
        onSelected: (val) {
          _g.selectgroup(i);
        },
        label: Text(_groups[i].name),
      ),
      itemCount: _groups.length,
    );
  }
}
