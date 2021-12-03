import 'package:flutter/material.dart';

class RgbColor {
  static _parseComponents(String input, String prefix, [String postfix = ")"]) {
    if (input.startsWith(prefix) && input.contains(postfix)) {
      return new List.from(input
          .substring(prefix.length, input.indexOf(postfix))
          .split(",")
          .map((c) => num.parse(c))
          .toList());
    }
    return [];
  }

  static Color parseRgb(String input) {
    var comps = _parseComponents(input, "rgb(");
    return Color.fromRGBO(
      comps.length > 0 ? comps[0] : 0,
      comps.length > 1 ? comps[1] : 0,
      comps.length > 2 ? comps[2] : 0,
      1.0,
    );
  }

  static Color parseRgba(String input) {
    var comps = _parseComponents(input, "rgba(");
    return Color.fromRGBO(
      comps.length > 0 ? comps[0] : 0,
      comps.length > 1 ? comps[1] : 0,
      comps.length > 2 ? comps[2] : 0,
      comps.length > 3 ? comps[3] + 0.0 : 1.0,
    );
  }
}
