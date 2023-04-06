import 'package:find/feed/feed_repository.dart';
import 'package:find/interfaces/user_finds.dart';

class FeedService {
  final FeedRepository _feedRepository = FeedRepository();

  Future<List<UserFinds>> getFeedsForUser(String uid) async {
    return await _feedRepository.getUserFindsFromFirestore(uid);
  }
}
