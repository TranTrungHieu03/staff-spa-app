import 'package:staff_app/features/chat/domain/entities/user_chat.dart';

class UserChatModel extends UserChat {
  UserChatModel(
      {required super.id,
      required super.email,
      required super.password,
      required super.fullName,
      required super.userId,
      required super.image});

  factory UserChatModel.fromJson(Map<String, dynamic> json) => UserChatModel(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        fullName: json["fullName"],
        userId: json["userId"] != null ? int.parse(json["userId"].toString()) : 0,
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "fullName": fullName,
        "userId": userId,
        "image": image,
      };
}
