import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WaitingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: SpinKitCubeGrid(color: Colors.blueGrey[200], size: 50.0),
          )),
    );
  }
}
