import 'package:find/widgets/upload_find_modal.dart';
import 'package:flutter/material.dart';

class NewFindFAB extends StatelessWidget {
  const NewFindFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void showSheet() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const UploadFindModal()),
      );
    }

    return FloatingActionButton(
      onPressed: showSheet,
      backgroundColor: const Color.fromRGBO(0, 129, 159, 1),
      child: Container(
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          padding: const EdgeInsets.all(5),
          child: const Icon(
            color: Color.fromRGBO(0, 129, 159, 1),
            Icons.add_rounded,
            size: 20,
            weight: 50,
          )),
    );
  }
}
