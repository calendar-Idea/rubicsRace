import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

// import 'package:http/http.dart' as http;

class Socket {
  var channel;
  var address;
  var listener;
  String name;

  Socket({@required this.address}) {}
  void initSocket() async {
    print("render");
    channel = await IOWebSocketChannel.connect(address);
    //sink adds to the buffer of sent messages
    channel.stream.listen((json) {
      if (listener != null) {
        listener(json);
      }
      //do changes based on input
    });

    sendName(name);
    // channel.sink.close(status.goingAway);
  }

  setListener(var listener) {
    this.listener = listener;
  }

  start(String name) {
    if (name.isNotEmpty) {
      print(name);
      this.name = name;
      initSocket();
    } else {
      //throw name empty
    }
  }

  sendName(String name) {
    Map<String, dynamic> nameJson = {"type": "name", "content": name};
    channel.sink.add(jsonEncode(nameJson));
  }

  sendWin() {
    Map<String, dynamic> nameJson = {
      "type": "status",
      "status": "win",
      "content": name,
    };
    channel.sink.add(jsonEncode(nameJson));
  }

  // closeSocket() {
  //   if (channel.sink) {
  //     channel.sink.close(status.goingAway);
  //   }
  // }
}
