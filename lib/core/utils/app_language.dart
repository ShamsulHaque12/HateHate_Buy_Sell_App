import 'package:flutter/foundation.dart';

class AppLanguage {
  AppLanguage._();

  /// Global ValueNotifier: true for Bengali (বাংলা), false for English (EN).
  static final ValueNotifier<bool> isBengali = ValueNotifier<bool>(true);

  /// Current boolean state
  static bool get current => isBengali.value;

  /// Update language globally across the entire app
  static void setLanguage(bool value) {
    if (isBengali.value != value) {
      isBengali.value = value;
    }
  }

  /// Toggle language between Bengali and English
  static void toggle() {
    isBengali.value = !isBengali.value;
  }
}
