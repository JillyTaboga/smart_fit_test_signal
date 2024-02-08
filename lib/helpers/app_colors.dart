import 'package:flutter/material.dart';

class AppColors {
  static Color darkGrey = HexColor.fromHex('#333333');
  static Color lightGrey = HexColor.fromHex('#808080');
  static Color yellow = HexColor.fromHex('#FFB612');
  static Color red = HexColor.fromHex('#dc0a17');
  static Color green = HexColor.fromHex('#2FC022');
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';

  String get colorToHexString {
    return '#FF${value.toRadixString(16).substring(2, 8)}';
  }
}
