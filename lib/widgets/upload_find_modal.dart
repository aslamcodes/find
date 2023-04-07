import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UploadFindModal extends StatefulWidget {
  final String? initialText;
  const UploadFindModal({Key? key, this.initialText}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UploadFindModalState();
}

class _UploadFindModalState extends State<UploadFindModal> {
  late TextEditingController linkController;
  late TextEditingController descriptionController;

  void _uploadFinds(BuildContext context) async {
    final findsCollectionRef = FirebaseFirestore.instance.collection('finds');
    final findsQuerySnapshot = await findsCollectionRef
        .where('uid', isEqualTo: context.read<User?>()?.uid)
        .get();
    final dataToAdd = {
      'description': descriptionController.text,
      'source': linkController.text
    };

    if (findsQuerySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = findsQuerySnapshot.docs.first;
      List<dynamic> arrayFieldValue = List.from(documentSnapshot['finds']);
      arrayFieldValue.add(dataToAdd);

      await findsCollectionRef
          .doc(documentSnapshot.id)
          .update({'finds': arrayFieldValue});
    } else {
      await findsCollectionRef.add({
        'finds': [dataToAdd],
        'uid': context.read<User?>()?.uid
      });
    }
  }

  @override
  void initState() {
    super.initState();
    linkController = TextEditingController();
    linkController.text = widget.initialText ?? '';
    descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.2,
      maxChildSize: 1,
      builder: (context, scrollController) {
        return Column(
          children: [
            SizedBox(
              width: 70,
              height: 5,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey),
              ),
            ),
            const SizedBox(height: 7),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                  child: Column(
                    children: [
                      TextField(
                        controller: linkController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(0, 129, 159, 1))),
                            label: Text(
                              "Paste your link here",
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 129, 159, 1)),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(0, 129, 159, 1))),
                            label: Text(
                              "Say Something about",
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 129, 159, 1)),
                            )),
                      ),
                      Expanded(
                        child: Center(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith((states) =>
                                          Color.fromRGBO(0, 129, 159, 1))),
                              onPressed: () {
                                _uploadFinds(context);
                              },
                              child: const Text("Send to your finders")),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        );
      },
    );
  }
}
