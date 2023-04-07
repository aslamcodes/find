import 'package:flutter/material.dart';

class FindTextInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const FindTextInput({Key? key, required this.controller, required this.label})
      : super(key: key);

  @override
  _FindTextInputState createState() => _FindTextInputState();
}

class _FindTextInputState extends State<FindTextInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(0, 129, 159, 1))),
          label: Text(
            widget.label,
            style: TextStyle(color: Color.fromRGBO(0, 129, 159, 1)),
          )),
    );
  }
}
