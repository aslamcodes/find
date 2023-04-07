import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find/interfaces/user_finds.dart';

class FeedRepository {
  Future<List<UserFinds>> getUserFindsFromFirestore(String? uid) async {
    final db = FirebaseFirestore.instance;

    final userFriendsSnapshot =
        await db.collection('users').doc(uid).collection('friends').get();

    final userFindsList =
        await Future.wait(userFriendsSnapshot.docs.map((friend) async {
      final friendUser =
          (await db.collection('users').doc(friend.id).get()).data();
      final friendFindsSnapshot =
          await db.collection('finds').where('uid', isEqualTo: friend.id).get();

      final friendFinds = friendFindsSnapshot.docs
          .expand((friendDoc) => friendDoc.data()['finds'])
          .map((findMap) => Find.fromMap(findMap))
          .toList();

      return UserFinds(
          finds: friendFinds,
          user: friendUser?['username'],
          userProfile: friendUser?['profile_picture']);
    }));

    return userFindsList;
  }
}
