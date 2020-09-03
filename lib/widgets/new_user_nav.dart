import 'package:flutter/material.dart';
import 'package:genesis/providers/new_user_provider.dart';
import 'package:provider/provider.dart';

class NewUserNav extends StatefulWidget {
  final FocusScopeNode _focus;

  final List<TextEditingController> _list;
  final PageController _controller;
  @override
  NewUserNav(this._controller, this._list, this._focus);
  _NewUserNavState createState() => _NewUserNavState();
}

class _NewUserNavState extends State<NewUserNav> {
  FocusNode node = new FocusNode();
  bool _fp = true, _lp = false;
  void listen() {
    setState(() {
      final _page = widget._controller.page;
      if (_page == 0) {
        _fp = true;
        _lp = false;
      } else if (_page == 2) {
        _lp = true;
        _fp = false;
      } else {
        _fp = false;
        _lp = false;
      }
    });
  }

  @override
  void dispose() {
    widget._controller.dispose();
    widget._list.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _page = widget._controller.page;
    return Row(
      mainAxisAlignment:
          _fp ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
      children: [
        if (!_fp)
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: FloatingActionButton.extended(
              onPressed: () {
                if (_page == 0.0 && widget._focus.hasFocus) {
                  widget._focus.unfocus();
                  Future.delayed(Duration(milliseconds: 300));
                }
                widget._controller
                    .previousPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInQuad)
                    .then((value) => listen());
              },
              label: Row(
                children: [
                  Icon(Icons.keyboard_arrow_left),
                  const Text("PREV"),
                ],
              ),
            ),
          ),
        if (!_fp)
          Row(
            children: [
              Icon(
                Icons.brightness_1,
                size: 15,
                color: _page == 0 ? Colors.green : Colors.black,
              ),
              Icon(
                Icons.brightness_1,
                size: 15,
                color: _page == 1 ? Colors.green : Colors.black,
              ),
              Icon(
                Icons.brightness_1,
                size: 15,
                color: _page == 2 ? Colors.green : Colors.black,
              ),
            ],
          ),
        FloatingActionButton.extended(
          onPressed: () async {
            if (_page == 0.0 && widget._focus.hasFocus) {
              widget._focus.unfocus();
              Future.delayed(Duration(milliseconds: 300));
            }
            _lp
                ? Provider.of<NewUserInfo>(context, listen: false)
                    .submit(widget._list)
                    .catchError((err) {
                    print(err.toString());
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text(err.toString())));

                    widget._controller
                        .animateToPage(
                            err == "Select atleast one usergroup" ? 2 : 0,
                            duration: Duration(milliseconds: 30),
                            curve: Curves.bounceIn)
                        .then((value) => listen());
                  })
                : widget._controller
                    .nextPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInQuad)
                    .then((value) => listen());
          },
          label: Row(
            children: _lp
                ? [const Text("SUBMIT"), Icon(Icons.done)]
                : [const Text("NEXT"), Icon(Icons.keyboard_arrow_right)],
          ),
        )
      ],
    );
  }
}
