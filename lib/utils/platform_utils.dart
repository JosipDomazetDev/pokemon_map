import 'dart:io';

import 'package:flutter/foundation.dart';

class PlatformUtils {
  static bool get isMobile {
    if (kIsWeb) {
      return false;
    } else {
      return Platform.isIOS || Platform.isAndroid;
    }
  }

  static bool get isWindows {
    if (kIsWeb) {
      return false;
    } else {
      return Platform.isWindows;
    }
  }

  static bool get isDesktop {
    if (kIsWeb) {
      return false;
    } else {
      return Platform.isLinux || Platform.isFuchsia || Platform.isWindows || Platform.isMacOS;
    }
  }

  static bool get isTest {
    if (kIsWeb) {
      return false;
    } else {
      return Platform.environment['FLUTTER_TEST'] == 'true';
    }
  }
}
