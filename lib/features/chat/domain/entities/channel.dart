class Channel {
  final String id;
  final String name;
  final int appointmentId;
  final List<String> members;
  final String admin;

  Channel({
    required this.id,
    required this.name,
    required this.appointmentId,
    required this.members,
    required this.admin,
  });
}
