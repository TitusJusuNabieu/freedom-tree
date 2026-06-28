import 'dart:io';
import 'package:flutter/foundation.dart';

/// Base URL for the Next.js API. The Android emulator can't resolve
/// "localhost" to the host machine (it's the emulator's own loopback), so it
/// uses the documented special alias 10.0.2.2 instead. iOS simulator and
/// real devices on the same network can use the host's actual address.
/// Override with --dart-define=API_BASE_URL=... for staging/prod builds.
String get apiBaseUrl {
  const override = String.fromEnvironment('API_BASE_URL');
  if (override.isNotEmpty) return override;

  if (!kIsWeb && Platform.isAndroid) {
    return 'http://10.0.2.2:3000/api';
  }
  return 'http://localhost:3000/api';
}
