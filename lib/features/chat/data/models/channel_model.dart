import 'package:staff_app/features/chat/data/models/user_chat_model.dart';
import 'package:staff_app/features/chat/domain/entities/channel.dart';


class ChannelModel extends Channel {
  final List<String> messages;

  final UserChatModel? adminDetails;
  final List<UserChatModel>? memberDetails;

  ChannelModel(
      {required super.id,
        required super.name,
        required super.appointmentId,
        required super.members,
        required super.admin,
        required this.adminDetails,
        required this.memberDetails,
        required this.messages});

  factory ChannelModel.fromJson(Map<String, dynamic> json) => ChannelModel(
      id: json["id"],
      name: json["name"],
      adminDetails: json['adminDetails'] != null ? UserChatModel.fromJson(json['adminDetails']) : null,
      memberDetails: json['memberDetails'] != null ? (json['memberDetails'] as List).map((x) => UserChatModel.fromJson(x)).toList() : [],
      appointmentId: json["appointmentId"],
      members: List<String>.from(json["members"].map((x) => x)),
      admin: json["admin"],
      messages: List<String>.from(json["messages"].map((x) => x)));
}
