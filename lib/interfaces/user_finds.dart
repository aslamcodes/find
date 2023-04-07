enum FindSMEnum {
  spotify('assets/icons/spotify.svg'),
  youtube('assets/icons/youtube.svg'),
  facebook('assets/icons/facebook.svg');

  const FindSMEnum(this.name);

  final String name;

  static FindSMEnum urlToIcon(String url) {
    if (url.contains('spotify')) {
      return FindSMEnum.spotify;
    } else if (url.contains('youtube')) {
      return FindSMEnum.youtube;
    } else if (url.contains('facebook')) {
      return FindSMEnum.facebook;
    } else {
      //Todo: Fix this Dump invalid case
      return FindSMEnum.facebook;
    }
  }
}

class Find {
  final FindSMEnum type;
  final String dataURL;

  const Find({
    required this.type,
    required this.dataURL,
  });

  factory Find.fromMap(Map<String, dynamic> json) {
    return Find(
        dataURL: json['source'], type: FindSMEnum.urlToIcon(json['source']));
  }
}

class UserFinds {
  final List<Find> finds;
  final String user;
  final String userProfile;
  const UserFinds(
      {required this.finds, required this.user, required this.userProfile});

  factory UserFinds.fromMap(Map<String, dynamic> json) {
    return UserFinds(
        finds: json['finds'],
        user: json['username'],
        userProfile: json['profile_image']);
  }
}
