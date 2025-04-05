import 'package:staff_app/features/chat/domain/entities/channel.dart';

class ChannelModel extends Channel {
  final List<String> messages;

  ChannelModel(
      {required super.id,
      required super.name,
      required super.appointmentId,
      required super.members,
      required super.admin,
      required this.messages});

  factory ChannelModel.fromJson(Map<String, dynamic> json) => ChannelModel(
      id: json["id"],
      name: json["name"],
      appointmentId: json["appointmentId"],
      members: List<String>.from(json["members"].map((x) => x)),
      admin: json["admin"],
      messages: List<String>.from(json["messages"].map((x) => x)));
}
