class UserData {
  final String? uid;
  final String? name;
  final String? email;
  final String? photo;

  UserData({this.uid, this.name, this.email, this.photo});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"uid": uid, "name": name, "email": email, "photo": photo};
  }
}
