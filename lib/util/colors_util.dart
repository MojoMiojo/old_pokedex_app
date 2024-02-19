import 'dart:ui';

import 'package:flutter/material.dart';

class ColorsUtil {
  static Color takeColor(String cor) {
    switch (cor) {
      case "black":
        return ColorsUtil.black;
        break;
      case "blue":
        return ColorsUtil.blue;
        break;
      case "brow":
        return ColorsUtil.brow;
        break;
      case "gray":
        return ColorsUtil.gray;
        break;
      case "green":
        return ColorsUtil.green;
        break;
      case "pink":
        return ColorsUtil.pink;
        break;
      case "purple":
        return ColorsUtil.purple;
        break;
      case "red":
        return ColorsUtil.red;
        break;
      case "white":
        return ColorsUtil.gray;
        break;
      case "yellow":
        return ColorsUtil.yellow;
        break;
      default:
        return ColorsUtil.red;
    }
  } //end take color

  static final black = getColorByHex('#121211');
  static final blue = getColorByHex('#316bd6');
  static final brow = getColorByHex('#a65703');
  static final gray = getColorByHex('#6e6c6b');
  static final green = getColorByHex('#13f2a1');
  static final pink = getColorByHex('#e35fb3');
  static final purple = getColorByHex('#b43ae8');
  static final red = getColorByHex('#db380b');
  static final white = getColorByHex('#ffffff');
  static final yellow = getColorByHex('#e6ed1c');

  static Color getColorByHex(String hex) {
    return Color(int.parse("0xFF${hex.replaceAll('#', '')}"));
  }
}
