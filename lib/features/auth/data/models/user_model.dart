class UserData {
  final String? name;
  final String? email;
  final String? uid;
  final bool isAdmin;
  final bool isBlocked;

  UserData({
    this.name,
    this.email,
    this.uid,
    this.isAdmin = false,
    this.isBlocked = false,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      email: json['email'],
      uid: json['uid'],
      isAdmin: json['isAdmin'] ?? false,
      isBlocked: json['isBlocked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'isAdmin': isAdmin,
      'isBlocked': isBlocked,
    };
  }

  UserData copyWith({
    String? name,
    String? email,
    String? uid,
    bool? isAdmin,
    bool? isBlocked,
  }) {
    return UserData(
      name: name ?? this.name,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      isAdmin: isAdmin ?? this.isAdmin,
      isBlocked: isBlocked ?? this.isBlocked,
    );
  }
}
