class UserModelData {
  String name;
  String email;
  String uid;
  UserModelData({required this.email, required this.name,required this.uid});

  factory UserModelData.fromJson(Map<String, dynamic> json) => UserModelData(
        email: json["email"],
        name: json["name"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
      };
}
