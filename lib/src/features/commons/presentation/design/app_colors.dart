import 'package:flutter/painting.dart';

abstract final class AppColors {
  static const transparent = Color(0x00000000);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);

  static const primary = Color(0xFFED2080);
  static const secondary = Color(0xFF31C3E7);

  static const accentOrange = Color(0xFFFF7A21);

  static const bronzeHeader = Color(0xFFFFEFE2);
  static const silverHeader = Color(0xFFF5F6F8);
  static const goldHeader = Color(0xFFFFF8E4);

  static const blue = Color(0xFF1692F9);
  static const green = Color(0xFF4CAF50);
  static const red = Color(0xFFEF4444);
  static const yellow = Color(0xFFFFEB3B);
  static const purple = Color(0xFF007AFF);

  static const neutral50 = Color(0xFFF3F3F3);
  static const neutral100 = Color(0xFFE7E7E7);
  static const neutral200 = Color(0xFFD0D0D0);
  static const neutral300 = Color(0xFFB5B5B5);
  static const neutral400 = Color(0xFF979797);
  static const neutral500 = Color(0xFF7A7A7A);
  static const neutral600 = Color(0xFF616161);
  static const neutral700 = Color(0xFF4A4A4A);
  static const neutral800 = Color(0xFF343434);
  static const neutral900 = Color(0xFF1F1F1F);
  static const neutral950 = Color(0xFF111111);

  static const offWhite = neutral50;
  static const softGrey = neutral100;
  static const grey = neutral500;
  static const darkGrey = neutral900;
  static const offBlack = neutral950;

  static const success = green;
  static const error = red;
}
