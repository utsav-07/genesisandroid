import 'package:flutter/material.dart';

class NewuserForm extends StatefulWidget {
//  final Function ass;
  final List<TextEditingController> _list;
  NewuserForm(this._list);
  @override
  _NewuserFormState createState() => _NewuserFormState();
}

class _NewuserFormState extends State<NewuserForm> {
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Card(
              child: TextFormField(
                controller: widget._list[0],
                decoration: InputDecoration(labelText: "Name"),
              ),
            ),
            Card(
              child: TextFormField(
                controller: widget._list[1],
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: "Roll Number"),
              ),
            ),
            Card(
              child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: "Year\n"),
                  items: [
                    DropdownMenuItem(
                      child: const Text("1st"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: const Text("2nd"),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: const Text("3rd"),
                      value: 3,
                    ),
                    DropdownMenuItem(
                      child: const Text("4th"),
                      value: 4,
                    )
                  ],
                  onChanged: (_s) {
                    widget._list[2].text = _s.toString();
                  }),
            ),
            Card(
              child: TextFormField(
                controller: widget._list[3],
                decoration: InputDecoration(labelText: "Branch"),
              ),
            ),
            Card(
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: widget._list[4],
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
            ),
            Card(
              child: TextFormField(
                controller: widget._list[5],
                decoration: InputDecoration(labelText: "Password"),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
