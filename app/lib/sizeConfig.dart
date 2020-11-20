import 'package:app/IboardSize.dart';
import 'package:flutter/widgets.dart';

class SizeConfig implements IboardSize {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }

  double getWidth() {
    return screenWidth;
  }

  double getHeight() {
    return screenHeight;
  }
}
