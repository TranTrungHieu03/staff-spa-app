import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:staff_app/core/logger/logger.dart';
import 'package:staff_app/core/utils/service/auth_service.dart';

class SocketIOService {
  static final SocketIOService _instance = SocketIOService._internal();

  factory SocketIOService() => _instance;

  late IO.Socket _socket;
  final AuthService _authService = AuthService();

  SocketIOService._internal() {
    initSocket();
  }

  Future<void> initSocket() async {
    String token = await _authService.getToken() ?? "";
    _socket = IO.io(
      'https://socket-io-chat.now.sh/',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({
            'Authorization': 'Bearer $token',
          })
          .build(),
    );
    _socket.connect();

    _socket.onConnect((_) {
      AppLogger.info('Socket connected, ${_socket.id}');
    });
    _socket.onDisconnect((_) {
      AppLogger.info('Socket disconnected');
    });
  }
}
