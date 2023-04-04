import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadFindModal extends StatefulWidget {
  const UploadFindModal({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UploadFindModalState();
}

class _UploadFindModalState extends State<UploadFindModal> {
  late TextEditingController linkController;

  void _uploadFinds(BuildContext context) async {
    final findsCollectionRef = FirebaseFirestore.instance.collection('finds');
    final findsQuerySnapshot = await findsCollectionRef
        .where('uid', isEqualTo: context.read<User?>()?.uid)
        .get();
    final dataToAdd = {'description': "Testing", 'source': linkController.text};

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
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.2,
      maxChildSize: 1,
      builder: (context, scrollController) {
        return Container(
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(Icons.link),
                    Text("Paste your link here")
                  ],
                ),
                TextField(
                  controller: linkController,
                ),
                ElevatedButton(
                    onPressed: () {
                      print(Uri.parse(linkController.text).host.isNotEmpty);
                      _uploadFinds(context);
                    },
                    child: const Text("Send to your finders"))
              ],
            ));
      },
    );
  }
}
