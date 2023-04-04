enum FindSMEnum {
  spotify('assets/icons/spotify.svg'),
  youtube('assets/icons/youtube.svg'),
  facebook('assets/icons/facebook.svg');

  const FindSMEnum(this.name);

  final String name;
}

class Find {
  final FindSMEnum type;
  final String dataURL;

  const Find({
    required this.type,
    required this.dataURL,
  });
}

class UserFinds {
  final List<Find> finds;
  final String user;
  const UserFinds({required this.finds, required this.user});
}
