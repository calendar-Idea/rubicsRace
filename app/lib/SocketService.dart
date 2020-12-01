import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket socket;

  SocketService() {
    createSocketConnection();
  }

  void createSocketConnection() {
    socket = IO.io("ws://10.0.2.2:8080/", <String, dynamic>{
    });
    print("Nicee");
    this.socket.on("connect", (_) => print('Connected'));
    this.socket.on("disconnect", (_) => print('Disconnected'));
  }
}
