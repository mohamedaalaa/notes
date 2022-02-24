


class User {
  User({
   required this.username,
   required this.password,
   required this.email,
   required this.imageAsBase64,
   required this.intrestId,
   required this.id,
  });

  String username;
  String password;
  String email;
  String imageAsBase64;
  String intrestId;
  String id;

  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json["username"]??"",
    password: json["password"]??"",
    email: json["email"]??"",
    imageAsBase64: json["imageAsBase64"] ?? "",
    intrestId: json["intrestId"]??"",
    id: json["id"]??"",
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "email": email,
    "imageAsBase64": imageAsBase64 == null ? null : imageAsBase64,
    "intrestId": intrestId,
    "id": id,
  };
}
