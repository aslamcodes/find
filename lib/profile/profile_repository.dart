import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find/interfaces/user_finds.dart';

class ProfileRepository {
  Future<List<Find>> getUserFinds(String uid) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> userFinds =
        await db.collection('finds').where('uid', isEqualTo: uid).get();

    if (userFinds.docs.isEmpty) return [];

    List<dynamic> finds = userFinds.docs.first.data()['finds'];

    return finds.map((e) => Find.fromMap(e)).toList();
  }
}
