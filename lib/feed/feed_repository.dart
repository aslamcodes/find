import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find/interfaces/user_finds.dart';

class FeedRepository {
  Future<List<UserFinds>> getUserFindsFromFirestore(String? uid) async {
    List<UserFinds> userFindsList = [];
    final db = FirebaseFirestore.instance;

    final friends =
        await db.collection('users').doc(uid).collection('friends').get();

    for (var friend in friends.docs) {
      final friendUser = await db.collection('users').doc(friend.id).get();
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

      userFindsList.add(
          UserFinds(finds: friendFinds, user: friendUser.data()?['username']));
    }

    return userFindsList;
  }
}
