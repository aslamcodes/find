import 'dart:async';

import 'package:find/widgets/upload_find_modal.dart';
import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class NewFindFAB extends StatefulWidget {
  const NewFindFAB({Key? key}) : super(key: key);

  @override
  State<NewFindFAB> createState() => _NewFindFABState();
}

class _NewFindFABState extends State<NewFindFAB> {
  late StreamSubscription _intentDataStreamSubscription;
  String? _sharedText;

  @override
  void initState() {
    super.initState();
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      setState(() {
        _sharedText = value;
      });
    }, onError: (err) {
      // print("getLinkStream error: $err");
    });

    ReceiveSharingIntent.getInitialText().then((value) {
      setState(() {
        _sharedText = value;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  void _showSheet(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: UploadFindModal(
            initialText: _sharedText,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_sharedText != null) {
        _showSheet(context);
        _sharedText = null;
      }
      ;
    });
    return FloatingActionButton(
      onPressed: () => _showSheet(context),
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
