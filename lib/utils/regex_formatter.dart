import 'package:flutter/services.dart';

class RegexFormatter extends TextInputFormatter {
  RegexFormatter(this.regExp) : assert(regExp != null);

  final RegExp regExp;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty ||
        !newValue.composing.isCollapsed ||
        !newValue.selection.isCollapsed) {
      return newValue;
    }
    final Iterable<RegExpMatch> matches = regExp.allMatches(newValue.text);
    if (matches.length == 1 &&
        matches.first.group(0).toString() == newValue.text) {
      return newValue;
    }
    return oldValue;
  }
}