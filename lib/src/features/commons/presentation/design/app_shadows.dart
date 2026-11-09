import 'package:flutter/painting.dart';

abstract final class AppShadows {
  static const md = BoxShadow(
    offset: Offset(0, 3),
    blurRadius: 3,
    color: Color.fromARGB(30, 0, 0, 0),
  );

  static const lg = BoxShadow(
    offset: Offset(0, 4),
    blurRadius: 4,
    color: Color.fromARGB(38, 0, 0, 0),
  );
}
