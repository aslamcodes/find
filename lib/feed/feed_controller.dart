import 'package:find/feed/feed_service.dart';
import 'package:find/interfaces/user_finds.dart';

class FeedsController {
  final FeedService _feedService = FeedService();

  Future<List<UserFinds>> getFeedsForUser(String uid) async {
    return await _feedService.getFeedsForUser(uid);
  }
}
