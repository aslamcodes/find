import 'package:flutter/material.dart';

class FindElevatedButton extends StatelessWidget {
  final void Function() onClick;
  final Widget child;
  const FindElevatedButton(
      {Key? key, required this.onClick, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => Color.fromRGBO(0, 129, 159, 1))),
        onPressed: onClick,
        child: child);
  }
}
