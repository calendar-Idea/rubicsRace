import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

class SocketIO {
  String address;
  IO.Socket socket;
  SocketIO(String address) {
    this.address = address;
    this.socket = IO.io(address);
    connect();
  }
  void connect() async {
    print("Connecting.....");
    socket.on('connect', (data) => {print("Connected")});
  }
}
