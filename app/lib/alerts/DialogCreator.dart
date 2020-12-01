import 'package:flutter/material.dart';

class DialogCreator {
  static showWaitingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Waiting"),
          );
        });
  }

  static void showWinnerDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("You Won!"),
          );
        });
  }

  static showLostDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext contex) {
          return AlertDialog(title: Text("You Lost!"));
        });
  }

  static handleStatus(String status, BuildContext context) {
    switch (status) {
      case ("Waiting"):
        showWaitingDialog(context);
        break;
      case ("Lost"):
        showLostDialog(context);
        break;
    }
  }
}
