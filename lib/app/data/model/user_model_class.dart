class UserModelData {
  String name;
  String email;
  String uid;
  String imageURL;
  UserModelData(
      {required this.email,
      required this.name,
      required this.uid,
      required this.imageURL});

  factory UserModelData.fromJson(Map<String, dynamic> json) => UserModelData(
        email: json["email"],
        name: json["name"],
        uid: json["uid"],
        imageURL: json["imageURL"],
      );

  Map<String, dynamic> toJson() =>
      {"email": email, "name": name, "uid": uid, "imageURL": imageURL};
}
