import 'package:find/interfaces/user_finds.dart';
import 'package:find/profile/profile_repository.dart';

class ProfileService {
  final ProfileRepository _profileRepository = ProfileRepository();
  Future<List<Find>> getUserFinds(String uid) {
    return _profileRepository.getUserFinds(uid);
  }
}
