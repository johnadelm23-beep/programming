class UserData {
  final String? name;
  final String? email;
  final String? uid;

  UserData({this.name, this.email, this.uid});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(name: json['name'], email: json['email'], uid: json['uid']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'uid': uid};
  }

  UserData copyWith({String? name, String? email, String? uid}) {
    return UserData(
      name: name ?? this.name,
      email: email ?? this.email,
      uid: uid ?? this.uid,
    );
  }
}
