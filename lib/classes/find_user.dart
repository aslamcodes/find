class FindUser {
  final String username;
  final String email;
  final String profileImage;

  const FindUser(
      {required this.username,
      required this.email,
      required this.profileImage});

  factory FindUser.fromJson(Map<String, dynamic> json) {
    return FindUser(
      // id: json['id'],
      profileImage: json['profile_picture'] ??
          "https://static.wikia.nocookie.net/despicableme/images/a/ac/BobYay.png/revision/latest?cb=20220129132453",
      username: json['username'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'profile_picture': profileImage,
      'username': username,
      'email': email,
    };
  }
}
