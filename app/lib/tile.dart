import 'package:flutter/cupertino.dart';
import 'IboardSize.dart';

class Tile extends StatelessWidget {
  final String color;
  final IboardSize boardSizing;
  final Function onTap;
  final x;
  final y;
  final int tableSize;

  Tile(
      {this.tableSize,
      this.color,
      this.boardSizing,
      this.onTap,
      this.x,
      this.y});

  @override
  Widget build(BuildContext context) {
    Image image = pickImage();
    return Container(
      child: GestureDetector(
        onTap: () => {onTap(x, y)},
        child: image,
      ),
    );
  }

  Image pickImage() {
    double width = boardSizing.getWidth() / tableSize;
    switch (color) {
      case "Yellow":
        return Image.asset(
          "assets/images/yellowTile.png",
          width: width,
          height: width,
        );
        break;
      case "White":
        return Image.asset(
          "assets/images/whiteTile.png",
          width: width,
          height: width,
        );
        break;
      case "Blue":
        return Image.asset(
          "assets/images/blueTile.png",
          width: width,
          height: width,
        );
        break;

      case "Orange":
        return Image.asset(
          "assets/images/orangeTile.png",
          width: width,
          height: width,
        );
        break;
      case "Red":
        return Image.asset(
          "assets/images/redTile.png",
          width: width,
          height: width,
        );
        break;
      case "Green":
        return Image.asset(
          "assets/images/greenTile.png",
          width: width,
          height: width,
        );
        break;
      default:
        return Image.asset(
          "assets/images/blackTile.png",
          width: width,
          height: width,
        );
    }
  }
}
