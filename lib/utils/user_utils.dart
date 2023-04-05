import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find/classes/user_finds.dart';

Future<List<UserFinds>> getUserFindsFromFirestore(String? uid) async {
  List<UserFinds> userFindsList = [];
  final db = FirebaseFirestore.instance;

  final friends =
      await db.collection('users').doc(uid).collection('friends').get();

  for (var friend in friends.docs) {
    final friendFindsSnapshot =
        await db.collection('finds').where('uid', isEqualTo: friend.id).get();

    final List<Find> friendFinds = [];
    for (var friendDoc in friendFindsSnapshot.docs) {
      List<dynamic> findData = friendDoc.data()['finds'];

      for (Map<String, dynamic> findMap in findData) {
        Find find = Find.fromMap(findMap);
        friendFinds.add(find);
      }
    }

    userFindsList.add(UserFinds(finds: friendFinds, user: "asd"));
  }

  return userFindsList;
}
